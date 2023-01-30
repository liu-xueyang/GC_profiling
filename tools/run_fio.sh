# Run all fio tests in one given directory
# Usage: first make sure under root user using sudo -s
# [root@flubber9 GC_profiling]# ./tools/run_fio.sh ./fio-RW/sequential results
# the first input is the directory where *.fio files are located
# the second input is the results directory, make sure root has write permission to it using chmod a+w results/
dir=$1
result_dir=$2 # result directory name
cd $dir
# mkdir $result_dir
# get file names from $dir
for file in $(find . -name "*.fio"); do
    # report WAF stats
    nvme intel smart-log-add /dev/nvme0n1 > tmp.txt
    nand_bytes_written=$(sed '12q;d' tmp.txt | awk '{print $4}')
    host_bytes_written=$(sed '13q;d' tmp.txt | awk '{print $4}')
    echo "Before starting "$file", nand_bytes_written: "$nand_bytes_written "host_bytes_written: "$host_bytes_written
    
    # run fio
    fio $file > $result_dir/$file-results
    echo "Saved test results to "$result_dir/$file-results
    # Delete previous test file and always write to the last 5%
    # rm /mnt/SmartSSD/fio-*
done
nvme intel smart-log-add /dev/nvme0n1 > tmp.txt
nand_bytes_written=$(sed '12q;d' tmp.txt | awk '{print $4}')
host_bytes_written=$(sed '13q;d' tmp.txt | awk '{print $4}')
echo "End of experiment, nand_bytes_written: "$nand_bytes_written "host_bytes_written: "$host_bytes_written 
rm tmp.txt
