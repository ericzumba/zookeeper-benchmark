# ZooKeeper Benchmark

Authors: Chen Liang, Andrew Ferguson, Rodrigo Fonseca

## Build and Installation

To compile the code, run: 

	mvn -DZooKeeperVersion=<version> package

where `<version>` is a ZooKeeper version such as 3.4.3, 3.5.0-pane, etc.

After this, to run the test, run like this:

	java -cp target/lib/*:target/* curatorTest 200 16000 6000 30000 0

Argument 200 means rate is recorded every 200 ms.

Argument 16000 and 6000 means that when the number of unfinished requests below 
6000, another bunch of requests are submitted such that total number of 
unfinished requests goes back to 16000.

Argument 30000 means each test would run for 30 seconds.

Argument 0 means test would submit asynchronous requests, 1 is for synchronous 
requests.


## Eclipse Development

As a simple Maven project, our benchmark can easily be developed using Eclipse.
It is necessary to first set the M2_REPO variable for your workspace (This
command only needs to be executed once per workspace):

	mvn -Declipse.workspace=<path-to-eclipse-workspace> eclipse:configure-workspace

Next, install the libraries and create the Eclipse project files:

	mvn -DZooKeeperVersion=<version> install -DskipTests
	mvn -DZooKeeperVersion=<version> eclipse:eclipse

You can now import the project into Eclipse using, File > Import > Existing
Projects into Workspace.

If you wish to view the source or JavaDocs of the benchmark's dependencies, you
add `-DdownloadSources=true` or `-DdownloadJavadocs=true` when creating the
Eclipse project files in the final step.

## Notes

1. In the benchmark, node creation and deletion tests are done by creating a lot
of nodes at first, and then deleting them. Since each test runs for a fixed 
amount of time, there are no guarantees about the number of nodes each creates.
If there are more delete requests than create requests, the extra delete 
requests would end up not actually deleting anything. Though these requests are 
sent and processed by ZooKeeper server anyway; this could be an issue.

2. Read requests done done by ZooKeeper extremly quickly compared with write 
requests. If the time interval and threshold are not chosen appropriately, it 
could happen that when the timer awakes, all requests have already been 
finished. In this case, the output of read test doesn't reflect the actual rate 
of read requests. 
