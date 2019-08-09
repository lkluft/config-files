# Configuration file for ipython.

c = get_config()

#------------------------------------------------------------------------------
# InteractiveShellApp configuration
#------------------------------------------------------------------------------

# lines of code to run at IPython startup.
c.InteractiveShellApp.exec_lines = [
    # IPython magic
    '%load_ext autoreload',
    '%autoreload 2',
    # Standard library imports
    'import glob',
    'import os',
    'import sys',
    # Third-party imports
    'import matplotlib as mpl',
    'import matplotlib.pyplot as plt',
    'import numpy as np',
    'import typhon as ty',
    # User "settings"
    'ty.plots.styles.use("typhon")',
    'from typhon.arts import xml',
]

#------------------------------------------------------------------------------
# TerminalInteractiveShell configuration
#------------------------------------------------------------------------------

# Set the color scheme (NoColor, Linux, or LightBG).
c.TerminalInteractiveShell.colors = 'Linux'

# Set the editing mode for sheel input to 'vi'.
c.TerminalInteractiveShell.editing_mode = 'vi'

# Autoindent IPython code entered interactively.
c.TerminalInteractiveShell.autoindent = True

# Evaluate code when hitting <TAB> in order to have completion for e.g. lists.
c.IPCompleter.greedy = True
