drop table graph;
drop table neighbor;

CREATE table graph (
	graph_node BIGINT,
	adjacent_node BIGINT)
row format delimited fields terminated by ',' stored as textfile;

CREATE table neighbor (
	node_count BIGINT)
row format delimited fields terminated by ',' stored as textfile;

load data local inpath '${hiveconf:G}' overwrite into table graph;

INSERT INTO TABLE neighbor
SELECT count(*)
FROM graph
GROUP BY graph_node;

SELECT node_count, count(*)
FROM neighbor
GROUP BY node_count
ORDER BY node_count desc;

