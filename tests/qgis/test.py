try:
    import fiona
    import flask
    import qgiscloud

    print("QGIS test script was successfully executed.")
    os._exit(0)  # iface.actionExit().trigger() doesn't work

except Exception as e:
    print("QGIS test script has failed.")
    print("Error message: {}".format(e))
    os._exit(1)
