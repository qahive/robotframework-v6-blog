import os
import time
from robot.utils import get_link_path
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn, RobotNotRunningError
from PIL import Image
from SeleniumLibrary.base import keyword


# create new class that inherits from SeleniumLibrary
class CustomSeleniumLibrary():
    ROBOT_LISTENER_API_VERSION = 3
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    
    ctx_fullpage = { 'screenshot_root_directory': ''}
    
    def __init__(self):
        self._screenshot_index = {}
        
    @keyword
    def set_fullpage_screenshot_directory(self, path, persist='DEPRECATED'):
        if self.is_noney(path):
            path = None
        else:
            path = os.path.abspath(path)
            self._create_product_report_directory(path)
        if persist != 'DEPRECATED':
            self.warn("'persist' argument to 'Set Screenshot Directory' "
                      "keyword is deprecated and has no effect.")
        previous = self.ctx_fullpage['screenshot_root_directory']
        self.ctx_fullpage['screenshot_root_directory'] = path
        return previous
        
    @keyword
    def capture_fullpage_screenshot(self, filename='selenium-screenshot-{index}.png'):
        driver = self._get_selenium_driver_instance()

        # Scroll to top before capture screen shot
        driver.execute_script("window.scrollTo(0, 0)")
        BuiltIn().sleep('2s')
        rectangles = []

        # Get the pixel ratio (Retina display ratio)
        pixel_ratio = driver.execute_script("return window.devicePixelRatio")

        total_width = int(driver.execute_script("return document.body.scrollWidth") * pixel_ratio)
        total_height = int(driver.execute_script("return document.body.parentNode.scrollHeight") * pixel_ratio)
        viewport_width = int(driver.execute_script("return document.body.clientWidth") * pixel_ratio)
        viewport_height = int(driver.execute_script("return window.innerHeight") * pixel_ratio)

        i = 0
        while i < total_height:
            ii = 0
            top_height = i + viewport_height

            if top_height > total_height:
                top_height = total_height

            while ii < total_width:
                top_width = ii + viewport_width
                if top_width > total_width:
                    top_width = total_width
                rectangles.append((ii, i, top_width, top_height))
                ii = ii + viewport_width

            i = i + viewport_height
        stitched_image = Image.new('RGB', (total_width, total_height))
        previous = None
        part = 0

        for rectangle in rectangles:
            if not previous is None:
                driver.execute_script("window.scrollTo({0}, {1})".format(rectangle[0] / pixel_ratio, rectangle[1] / pixel_ratio))
                time.sleep(0.2)

            file_name = "part_{0}.png".format(part)

            driver.get_screenshot_as_file(file_name)
            screenshot = Image.open(file_name)

            if rectangle[1] + viewport_height > total_height:
                offset = (rectangle[0], total_height - viewport_height)
            else:
                offset = (rectangle[0], rectangle[1])

            stitched_image.paste(screenshot, offset)

            del screenshot
            os.remove(file_name)
            part = part + 1
            previous = rectangle

        fullpage_screenshot_path = self._get_fullpage_screenshot_paths(filename)
        stitched_image.save(fullpage_screenshot_path)

        current_url = driver.current_url
        logger.info('</td></tr><tr><td colspan="3">'
                    '{url}'
                    '</td></tr>'
                    '<tr><td colspan="3">'
                    '<a href="{src}"><img src="{src}" width="800px"></a>'
            .format(
            url=current_url,
            src=get_link_path(fullpage_screenshot_path, self._log_dir())),
            html=True)

        return fullpage_screenshot_path
    
    # create a new keyword called "get webdriver instance"
    def get_webdriver_instance(self):
        return self._current_browser()
    
    def _get_screenshot_paths(self, filename):
        directory = self._log_dir()
        filename = filename.format(index=self._get_screenshot_index(filename))
        filename = filename.replace('/', os.sep)
        index = 0
        while True:
            index += 1
            formatted = filename.format(index=index)
            path = os.path.join(directory, formatted)
            # filename didn't contain {index} or unique path was found
            if formatted == filename or not os.path.exists(path):
                return path

    def _get_fullpage_screenshot_paths(self, filename):
        directory = self.ctx_fullpage['screenshot_root_directory'] or self._log_dir()
        filename = filename.replace('/', os.sep)
        index = 0
        while True:
            index += 1
            formatted = filename.format(index=index)
            path = os.path.join(directory, formatted)
            # filename didn't contain {index} or unique path was found
            if formatted == filename or not os.path.exists(path):
                return path

    def _get_screenshot_index(self, filename):
        if filename not in self._screenshot_index:
            self._screenshot_index[filename] = 0
        self._screenshot_index[filename] += 1
        return self._screenshot_index[filename]

    def _log_dir(self):
        logfile = BuiltIn().get_variable_value('${LOG FILE}')
        if logfile == 'NONE':
            return BuiltIn().get_variable_value('${OUTPUTDIR}')
        return os.path.dirname(logfile)

    def _get_selenium_driver_instance(self):
        return BuiltIn().get_library_instance('SeleniumLibrary').driver
    
    def _create_product_report_directory(self, path):
        if not os.path.exists(path):
            os.makedirs(path)
            
    @keyword
    def is_noney(self, item):
        return item is None or self.is_string(item) and item.upper() == 'NONE'

    def is_string(self, item):
        return isinstance(item, (str))
