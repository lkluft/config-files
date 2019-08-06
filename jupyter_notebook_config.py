# NotebookApp configuration
c = get_config()

c.NotebookApp.open_browser = False  # Whether to open a browser on startup
c.NotebookApp.port = 4242  # Port the notebook server will listen on

# IPython magic
c.InteractiveShellApp.exec_lines = [
    '%matplotlib inline',
]
