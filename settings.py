# -*- coding: utf-8 -*-

INSTALLED_ADDONS = [
    # <INSTALLED_ADDONS>  # Warning: text inside the INSTALLED_ADDONS tags is auto-generated. Manual changes will be overwritten.
    'aldryn-addons',
    'aldryn-django',
    'aldryn-sso',
    'aldryn-django-cms',
    'aldryn-devsync',
    'aldryn-bootstrap3',
    'aldryn-common',
    'aldryn-disqus',
    'aldryn-events',
    'aldryn-faq',
    'aldryn-forms',
    'aldryn-jobs',
    'aldryn-newsblog',
    'aldryn-people',
    'aldryn-style',
    'cmsplugin-filer',
    'djangocms-googlemap',
    'djangocms-link',
    'djangocms-snippet',
    'djangocms-text-ckeditor',
    'django-filer',
    # </INSTALLED_ADDONS>
]

import aldryn_addons.settings
aldryn_addons.settings.load(locals())


# all django settings can be altered here

INSTALLED_APPS.extend([
    # add you project specific apps here
])

TEMPLATE_CONTEXT_PROCESSORS.extend([
    # add your template context processors here
])

MIDDLEWARE_CLASSES.extend([
    # add your own middlewares here
])

CMS_PAGE_WIZARD_CONTENT_PLACEHOLDER = 'content'

CKEDITOR_SETTINGS = {
    'stylesSet': 'default:/static/js/addons/ckeditor.wysiwyg.js',
    'contentsCss': ['/static/css/base.css'],
}
