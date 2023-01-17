# Run all fio tests in one given directory
dir=$1
cd $dir
mkdir results
# get file names from $dir
for file in $(find . -name "*.fio"); do 
    # run fio
    sudo fio $file > results/$file-results
    echo "Saved test results to "results/$file-results
done
