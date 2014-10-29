set -u
set -e
set -x

# setUp
workdir=fake_home.$$.tmp
mkdir $workdir
export HOME=$workdir
cd $workdir
touch skeleton diff1 diff2 # for tests
mkdir .vim
touch .vimrc
touch .bashrc
touch .bash_profile
ls -Fa | tee skeleton
cd -

# test_repeatable
./install $workdir
ls -Fa $workdir | tee $workdir/diff1
./install $workdir
ls -Fa $workdir | tee $workdir/diff1
diff $workdir/diff1 $workdir/diff1

# test_gitconfig
./install $workdir
[ -f $workdir/.gitconfig ]

# tearDown
rm -rf $workdir
