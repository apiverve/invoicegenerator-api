from setuptools import setup, find_packages

setup(
    name='apiverve_invoicegenerator',
    version='1.2.2',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'requests',
        'setuptools'
    ],
    description='Invoice Generator is an invoice generation API that creates downloadable PDF invoices from party addresses, line items, and payment terms. It computes subtotals with discounts and sales tax, returning an expiring download link.',
    author='APIVerve',
    author_email='hello@apiverve.com',
    url='https://apiverve.com/marketplace/invoicegenerator?utm_source=pypi&utm_medium=referral&utm_content=homepage',
    classifiers=[
        'Programming Language :: Python :: 3',
        'Operating System :: OS Independent',
    ],
    python_requires='>=3.6',
)
