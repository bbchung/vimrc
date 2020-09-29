python
import sys
sys.path.insert(0, '/usr/share/gcc-10/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

maint set worker-threads unlimited
set history save on
set history filename ~/.gdb_history
