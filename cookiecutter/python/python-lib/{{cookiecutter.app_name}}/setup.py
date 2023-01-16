import setuptools

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setuptools.setup(
    name="{{ cookiecutter.app_name | slugify }}",
    version="{{ cookiecutter.version }}",
    description="{{ cookiecutter.description }}",
    long_description=long_description,
    long_description_content_type="text/markdown",
    keywords='',

    author="{{ cookiecutter.author }}",
    author_email="{{ cookiecutter.author_email }}",

    url="{{ cookiecutter.url }}",
    project_urls={
        "Bug Tracker": "{{ cookiecutter.url }}/issues",
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        'License :: OSI Approved :: Apache Software License',
        "Operating System :: OS Independent",
    ],
    license="http://www.apache.org/licenses/LICENSE-2.0",
    py_modules=['{{ cookiecutter.module }}'],
    install_requires=[],
    extras_require={
        'test': ['coverage'],
    },
    package_dir={"": "src"},
    packages=setuptools.find_packages(where="src"),
    python_requires=">=3.6",
)
