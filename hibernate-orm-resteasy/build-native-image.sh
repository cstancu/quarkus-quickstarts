#!/bin/bash
set -x

# mvn -Dmaven.test.skip=true package -Pnative

mvn -Dmaven.test.skip=true package

which native-image

native-image -J-Djava.util.logging.manager=org.jboss.logmanager.LogManager --initialize-at-build-time= -H:InitialCollectionPolicy='com.oracle.svm.core.genscavenge.CollectionPolicy$BySpaceAndTime' -jar target/hibernate-orm-resteasy-1.0-SNAPSHOT-runner.jar -J-Djava.util.concurrent.ForkJoinPool.common.parallelism=1 -H:FallbackThreshold=0 -H:+ReportExceptionStackTraces -H:+PrintAnalysisCallTree -H:-AddAllCharsets -H:EnableURLProtocols=https --enable-all-security-services -H:NativeLinkerOption=-no-pie -H:-SpawnIsolates -H:+JNI --no-server -H:-UseServiceLoaderFeature -H:+StackTrace --initialize-at-run-time=org.wildfly.common.net.CidrAddress,org.wildfly.common.net.Inet 

# -Dsvm.platform='org.graalvm.nativeimage.impl.InternalPlatform$LINUX_JNI_AMD64'
