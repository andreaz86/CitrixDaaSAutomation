from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import sys

options = webdriver.ChromeOptions()
options.add_argument('--ignore-ssl-errors=yes')
options.add_argument('--ignore-certificate-errors')
driver = webdriver.Remote(
command_executor=sys.argv[1],
options=options
)
driver.get(sys.argv[2])
print(driver.title)
username_box = driver.find_element("id","username")
username_box.send_keys("nsroot")
password_box = driver.find_element("id","password")
password_box.send_keys(sys.argv[3])
password_box.send_keys(Keys.ENTER)
driver.implicitly_wait(15.0)
username_box = driver.find_element("id","username")
username_box.send_keys("nsroot")
password_box = driver.find_element("name","password")
password_box.send_keys(sys.argv[3])
npassword_box = driver.find_element("id","npassword")
npassword_box.send_keys(sys.argv[4])
new_password_box = driver.find_element("id","new_password")
new_password_box.send_keys(sys.argv[4])
new_password_box.send_keys(Keys.ENTER)
driver.close()
driver.quit()
