set -u
set -e
set -x

# __init__
workdir=tmp/fake_home.$$
mkdir $workdir
export HOME=$workdir

# setUp
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
[ -f $workdir/.gitconfig ]

# tearDown
rm -rf $workdir
