-- Load data from HDFS
inputFile = LOAD 'hdfs:///user/arpita/myfile.txt' AS (line:chararray);
-- Tokenize the lines in the file
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Group words by word
grpd = GROUP words BY word;
--count the total number of words
totalCount = FOREACH grpd GENERATE $0 , COUNT($1); 
-- Delete the output folder
rmf hdfs:///user/arpita/PigOutput;
--Store the output

STORE totalCount INTO 'hdfs:///user/arpita/PigOutput';
