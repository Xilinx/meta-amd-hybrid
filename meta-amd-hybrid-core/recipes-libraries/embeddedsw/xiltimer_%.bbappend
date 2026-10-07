XILTIMER_TICK_TTC_BASE ?= "ff0e0000"

def xiltimer_ttc_name(d, base):
    import os, re
    dtfile = d.getVar('CONFIG_DTFILE')
    if not dtfile or not os.path.isfile(dtfile):
        bb.fatal("xiltimer: CONFIG_DTFILE '%s' not found" % dtfile)
    bb.parse.mark_dependency(d, dtfile)
    with open(dtfile) as f:
        dts = f.read()
    node = re.search(r'(?:(\w+):\s*)?timer@%s\s*\{(.*?)\n\s*\};' % base, dts, re.S)
    if not node:
        bb.fatal("xiltimer: no timer@%s node in %s" % (base, dtfile))
    name = re.search(r'xlnx,name\s*=\s*"([^"]+)"', node.group(2))
    if name:
        return name.group(1)
    if node.group(1):
        return node.group(1)
    bb.fatal("xiltimer: timer@%s in %s has no xlnx,name or label" % (base, dtfile))

EXTRA_OECMAKE:append:amd-amr:xilinx-freertos = " \
    -DXILTIMER_tick_timer=${@xiltimer_ttc_name(d, d.getVar('XILTIMER_TICK_TTC_BASE'))} \
    -DXILTIMER_sleep_timer=Default \
    "
