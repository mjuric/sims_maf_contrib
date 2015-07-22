set -e
source eups-setups.sh
#conda install lsst-sims-maf -y
pip install runipy
setup sims_maf
git pull
cd tutorials
echo "Downloading necessary files"
wget -nc http://www.astro.washington.edu/users/lynnej/opsim/ops2_1114_sqlite.db
#http://ops2.tuc.noao.edu/runs/ops2_1114/data/ops2_1114_sqlite.db
if [[ ! -f enigma_1189_sqlite.db ]] 2>"f.out"; then
	wget -nc http://www.astro.washington.edu/users/lynnej/opsim/enigma_1189_sqlite.db.gz
	gunzip enigma_1189_sqlite.db.gz
fi 
echo "Setting up environment"
ERROR=0
for f in *.ipynb; do 
	echo "Processing $f"
	if [[ "$f" == SDSSSlicer.ipynb ]]; then
		continue
	fi
	if runipy "$f" "tested-$f" 2>"$f.out"; then
		echo "$f" passed.
	else
		echo "$f" failed.
		ERROR=1
	fi
done
exit $ERROR

