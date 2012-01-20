#!/bin/sh

rm -Rf tmp
mkdir -p tmp
cat > tmp/tmc-run <<EOS
#!/bin/sh
echo "ok" > output.txt
EOS
chmod +x tmp/tmc-run

tar -C tmp -cf tmp/bash-runner.tar tmc-run || exit 1

MAX_OUTPUT_SIZE=20M
dd if=/dev/zero of=tmp/output.tar bs=$MAX_OUTPUT_SIZE count=1

output/linux.uml \
  initrd=output/initrd.img \
  ubdarc=output/rootfs.squashfs \
  ubdbr=tmp/bash-runner.tar \
  ubdc=tmp/output.tar \
  mem=96M \
  tmc_run_bash

