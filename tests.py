from selenium import webdriver
import unittest


class TestCalculator(unittest.TestCase):

    def setUp(self):
        self.browser = webdriver.Chrome()

    def tearDown(self):
        self.browser.quit()

    def test_title(self):
        self.browser.get('http://localhost:5000/')
        self.assertEqual(self.browser.title, 'Storenet')

    def test_math(self):
        self.browser.get('http://localhost:5000/')

        x = self.browser.find_element_by_id('x-field')
        x.send_keys("00000")
        y = self.browser.find_element_by_id('y-field')
        y.send_keys("a")

        btn = self.browser.find_element_by_link_text('calc-button')
        btn.click()

        result = self.browser.find_element_by_id('result')
        self.assertEqual(result.text, "7")

if __name__ == "__main__":
    unittest.main()
