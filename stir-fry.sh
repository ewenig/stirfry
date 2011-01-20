#!/bin/bash

wget -O /users/u18/eli/stirfry/gracies-weekly.cfm http://finweb.rit.edu/diningservices/forms/webmenus/gracies-weekly.cfm
perl /users/u18/eli/stirfry/stir-fry.pl > /users/u18/eli/public_html/stirfry/index.htm
