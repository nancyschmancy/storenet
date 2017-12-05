from selenium import webdriver
import unittest


class TestCalculator(unittest.TestCase):

    # def setUp(self):
    #     self.browser = webdriver.PhantomJS()

    # def tearDown(self):
    #     self.browser.quit()

    # def test_title(self):
    #     self.browser.get('http://localhost:5000/')
    #     self.assertEqual(self.browser.title, 'Welcome to Storenet')

    def test_read(self):

        for i in [u'00009', u'00010', u'00011', u'00012', u'00013', u'00014', u'00015', u'00016', u'00017', u'00018', u'00019', u'00020', u'00021', u'00023', u'00024', u'00025', u'00026', u'00027', u'00028', u'00029', u'00030', u'00031', u'00032', u'00033', u'00035', u'00036', u'00037', u'00038', u'00039', u'00042', u'00043', u'00044', u'00051', u'00052', u'00053', u'00054', u'00055', u'00056', u'00057', u'00059', u'00060', u'00063', u'00065', u'00069', u'00070', u'00071', u'00073', u'00075', u'00078', u'00079', u'00080', u'00082', u'00083', u'00087', u'00088', u'00096', u'00098', u'00101', u'00102', u'00108', u'00127', u'00137', u'00138', u'00150', u'00167', u'00177', u'00180', u'00224']:
            self.browser = webdriver.PhantomJS()
            self.browser.get('http://localhost:5000/')

            x = self.browser.find_element_by_id('emp_id')
            x.send_keys(i)

            y = self.browser.find_element_by_id('password')
            y.send_keys("jjjj")

            btn = self.browser.find_element_by_id('submit')
            btn.click()

            link = self.browser.find_element_by_link_text('Holiday Hours Update')
            link.click()

            # result = self.browser.find_element_by_id('result')
            # self.assertEqual(result.text, "7")

            self.browser.quit()


if __name__ == "__main__":
    unittest.main()
