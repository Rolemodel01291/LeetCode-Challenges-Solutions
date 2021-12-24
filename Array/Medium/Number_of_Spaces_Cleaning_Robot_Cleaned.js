var numberOfCleanRooms = function( room ) {
        const direction = {
                "right": "down",
                "down": "left",
                "left": "top",
                "top": "right"
        }
        let currentDirection = "right";
        let i = 0;
        let j = 0;
        let noOfCellsRobotCleaned = 0;
        let visitedPositions = {};


        while( !( visitedPositions[i + "," + j + "," + currentDirection] ) ) {

                visitedPositions[i + "," + j + "," + currentDirection] = true;
                
                if( room[i][j] != 2 ) {
                        noOfCellsRobotCleaned++;
                }
                room[i][j] = 2;
                
                //MOVE RIGHT
                if( currentDirection == "right" ) {
                        j = j + 1;
                        //OUT OF GRID OR ROTATE 90 deg CLOCKWISE
                        if( j == room[i].length || room[i][j] == 1 ) {
                                j = j - 1;
                                //ROTATE 90 deg CLOCKWISE
                                currentDirection = direction[currentDirection];
                        }
                }

                //MOVE DOWN
                else if( currentDirection == "down" ) {
                        i = i + 1;
                        //OUT OF GRID OR ROTATE 90 deg CLOCKWISE
                        if( i == room.length || room[i][j] == 1 ) {
                                i = i - 1;
                                //ROTATE 90 deg CLOCKWISE
                                currentDirection = direction[currentDirection];
                        }
                }

                //MOVE LEFT
                else if( currentDirection == "left" ) {
                        j = j - 1;
                        //OUT OF GRID OR ROTATE 90 deg CLOCKWISE
                        if( j < 0 ||  room[i][j] == 1 ) {
                                j = j + 1;
                                //ROTATE 90 deg CLOCKWISE
                                currentDirection = direction[currentDirection];
                        }
                }

                else if( currentDirection == "top" ) {
                        i = i - 1;
                        //OUT OF GRID OR ROTATE 90 deg CLOCKWISE
                        if( i < 0 || room[i][j] == 1 ) {
                                i = i + 1;
                                //ROTATE 90 deg CLOCKWISE
                                currentDirection = direction[currentDirection];
                        }
                }
        }

        return noOfCellsRobotCleaned;
};