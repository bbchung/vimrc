set history save on
set history filename ~/.gdb_history
python
import sys
sys.path.insert(0, '/usr/share/gcc/python/')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end
