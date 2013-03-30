class bb_printer(gdb.Command):
  
  def __init__(self):
    gdb.Command.__init__(self, "dbb", gdb.COMMAND_DATA)

  def invoke(self, arg, from_tty):
    try:
      gdb.execute ("call debug_bb (" + arg + ")")
    except RuntimeError as e:
      print "error: exception occurred: %s" % e


class gimple_stmt_printer(gdb.Command):

  def __init__(self):
    gdb.Command.__init__(self, "dgst", gdb.COMMAND_DATA)

  def invoke(self, arg, from_tty):
    try:
      gdb.execute ("call debug_gimple_stmt (" + arg + ")")
    except RuntimeError as e:
      print "error: exception occurred: %s" % e


class tree_printer(gdb.Command):

  def __init__(self):
    gdb.Command.__init__(self, "dt", gdb.COMMAND_DATA)

  def invoke(self, arg, from_tty):
    try:
      gdb.execute ("call debug_tree (" + arg + ")")
    except RuntimeError as e:
      print "error: exception occurred: %s" % e


class loop_printer(gdb.Command):

  def __init__(self, num):
    self.num = str(num)
    gdb.Command.__init__(self, "dl" + self.num, gdb.COMMAND_DATA)

  def invoke(self, arg, from_tty):
    try:
      gdb.execute ("call debug_loop (" + arg + "," + self.num + ")")
    except RuntimeError as e:
      print "error: exception occurred: %s" % e
  

bb_printer()
gimple_stmt_printer()
tree_printer()
loop_printer(1)
loop_printer(2)
loop_printer(3)

