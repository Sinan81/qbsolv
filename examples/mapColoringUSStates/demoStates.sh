#!/bin/bash
#  Copyright 2016 D-Wave Systems,Inc.
#   
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#  					 
#  http://www.apache.org/licenses/LICENSE-2.0
#  									 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.


# Make a qubo from adj file

python adj2qubo.py -i usa.adj -o usa.qubo

# clean up old outputs if this script ran and aborted before:

if [ -e usa.qbout ] ; then
	rm -f usa.q*.svg  usa.qbout
fi
if [ -e /c/Users/trainee/Desktop/States ] ; then
	rm -rf /c/Users/trainee/Desktop/States
fi

subm=""
#dw get connection
#dw get solver
#subm=-S0

if [ `which qbsolv` ] ; then
	qbsolv -i usa.qubo -o usa.qbout -v1 -n 8 

	cat usa.qbout

	echo Solved -- Plotting
	./plotmap.sh 
else
	echo "./demoStates.sh: line 36: qbsolv: command not found"
	echo "run qbsolv by either indicating the exact path:"
	echo "    /path/to/qbsolv -i usa.qubo -o usa.qbout -v1 -n 8"
	echo "or by setting the environment variable PATH before line 36"
	echo '    export PATH=/path/to/qbsolv:${PATH}'
fi


