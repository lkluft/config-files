# Configuration file for ipython.

c = get_config()

#------------------------------------------------------------------------------
# InteractiveShellApp configuration
#------------------------------------------------------------------------------

# lines of code to run at IPython startup.
c.InteractiveShellApp.exec_lines = ['%load_ext autoreload', '%autoreload 2']

#------------------------------------------------------------------------------
# TerminalInteractiveShell configuration
#------------------------------------------------------------------------------

# Set the color scheme (NoColor, Linux, or LightBG).
c.TerminalInteractiveShell.colors = 'Linux'

# Set the editing mode for sheel input to 'vi'.
c.TerminalInteractiveShell.editing_mode = 'vi'

# Autoindent IPython code entered interactively.
c.TerminalInteractiveShell.autoindent = True
