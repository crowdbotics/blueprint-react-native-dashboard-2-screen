#!/bin/bash

# Initialize basic vars and helpers
source blueprint-lib/init.sh

##
# Add dependencies here
##

# source blueprint-lib/docker.sh

##
# ADD BLUEPRINT CODE BELOW HERE
#
# BASE_PATH is the full path to the project root
# APP_NAME is the name of the Django app that will be modified
##

BLUEPRINT="$3"
NAME="$4"

if [ -z "$BLUEPRINT" ]
then
    BLUEPRINT="Dashboard2Blueprint"
fi

if [ -z "$NAME" ] 
then
    NAME="Dashboard 2"
fi

DATA_1="{ name: '${BLUEPRINT}', human_name: '${NAME}', access_route: '${BLUEPRINT}'},"
DATA_2="import ${BLUEPRINT}Navigator from '..\/features\/${BLUEPRINT}\/navigator';"
DATA_3="${BLUEPRINT}: { screen: ${BLUEPRINT}Navigator },"

echo ">> remove blueprint folder"
if [ -d "$BASE_PATH/src/features/$BLUEPRINT" ]; then rm -Rf $BASE_PATH/src/features/$BLUEPRINT; fi

echo ">> remove 1" 
sed -i "/${DATA_1}/d" $BASE_PATH/src/config/installed_blueprints.js

echo ">> remove 2"
sed -i "/${DATA_2}/d" $BASE_PATH/src/navigator/mainNavigator.js

echo ">> remove 3"
sed -i "/${DATA_3}/d" $BASE_PATH/src/navigator/mainNavigator.js

BE_BLUEPRINT="dashboard"
DATA_4="path('api/v1/', include('${dashboard}.api.v1.urls')),"

echo "remove BE for Blueprint"
rm -Rf $BASE_PATH/backend/$BE_BLUEPRINT

echo ">> remove 4"
sed -i "/${DATA_4}/d" $PYTHON_URLS_PATH
sed -i "/${BE_BLUEPRINT}/d" $PYTHON_URLS_PATH

DATA_5="import ${BLUEPRINT}Reducer from '..\/features\/${BLUEPRINT}\/redux\/reducers'"
DATA_6="${BLUEPRINT}: ${BLUEPRINT}Reducer,"

echo ">> remove 5"
sed -i "/${DATA_5}/d" $BASE_PATH/src/redux/mainReducer.js

echo ">> remove 6"
sed -i "/${DATA_6}/d" $BASE_PATH/src/redux/mainReducer.js

DATA_7="import ${BLUEPRINT}Saga from '..\/features\/${BLUEPRINT}\/redux\/sagas'"
DATA_8="${BLUEPRINT}Saga,"

echo ">> remove 7"
sed -i "/${DATA_7}/d" $BASE_PATH/src/redux/mainSaga.js

echo ">> remove 8"
sed -i "/${DATA_8}/d" $BASE_PATH/src/redux/mainSaga.js