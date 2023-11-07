dedupcheck
===========

A quick and dirty check for duplicate files in a large filesystem

This program scans a set of directories on a filesystem to find potential duplicate files.  It aims to iterate through the system as quickly as possible.  To achieve this it:

1. Only looks at files above a certain cutoff size (100MB by default)
2. Compares file sizes and a hash of the first and last 10kb of the file
3. Uses the xxhash algorithm to compute hashes as quickly as possible

The program reports potential matches, but further validation should be done on the complete contents of these files before removing them to ensure that you aren't seeing an unlikely case of spurious matching (same size, same start and end, different middle).

Usage
-----

```
dedupcheck [dir1] [dir2] ... > possible_dups.txt
```

Output
------

A 4 column tab delimited text file

1. Duplicates
2. File path 1
3. File path 2
4. File size (bytes)


Testing
-------

Go into the ```testdata``` folder and run the ```make_test_data.sh``` script to generate a suitable test dataset.

From the main install directory run:

```
./dedupcheck testdata/
```

You should see:

```
Duplicates      testdata/file1  testdata/dup1   209715200
Duplicates      testdata/subdir/dup2    testdata/file2  209715200
```

The file ```notdup1``` shouldn't be reported as it differs at the end but not the start
The file ```notdup2``` shouldn't be reported as it is a hard link to the original file and not a duplicate

