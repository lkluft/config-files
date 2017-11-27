# -----------------------------------------------------------------------------
# NotebookApp configuration
# -----------------------------------------------------------------------------
c = get_config()

# Whether to open in a browser after starting. The specific browser used is
# platform dependent and determined by the python standard library `webbrowser`
# module, unless it is overridden using the --browser (NotebookApp.browser)
# configuration option.
c.NotebookApp.open_browser = False


# The port the notebook server will listen on.
def get_port():
    from socket import gethostname
    import re

    # Maps regex to port number.
    port_map = {
        'thunder7': 4201,
        'mlogin.*': 4202,
        'mistralpp.*': 4203,
    }

    hostname = gethostname()
    for pattern, value in port_map.items():
        if re.compile(pattern).match(hostname):
            # Return the corresponding port for first matching regex pattern.
            return value
    # Return default port if no match if found.
    return 8888


c.NotebookApp.port = get_port()

# Hashed password to use for web authentication.
#
# To generate, type in a python/IPython shell:
#
#   from IPython.lib import passwd; passwd()
#
# The string should be of the form type:salt:hashed-password.
c.NotebookApp.password = u'sha1:129681ef05fb:83a32ab1bd27080e880c6dfa3b7eb07a42338d4f'
