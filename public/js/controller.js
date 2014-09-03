app.controller('MainController', ["$scope", "$http", function($scope, $http) {

    $scope.currentBoard = [[{id: 'A1', state: '?'}, {id: 'A2', state: '?'}, {id: 'A3', state: '?'}],
                           [{id: 'B1', state: '?'}, {id: 'B2', state: '?'}, {id: 'B3', state: '?'}],
                           [{id: 'C1', state: '?'}, {id: 'C2', state: '?'}, {id: 'C3', state: '?'}]]

    $scope.toX = function(currentCell) {
        if (currentCell.state === '?') {
            currentCell.state = 'X'
            nextMove()
        }
    }

    var nextMove = function() {
        $http.post('/next_move',
                   $scope.currentBoard)
                   .success(function(data) {
                    console.log(data)
                    for (x = 0; x < 3; x++) {
                        for (y = 0; y < 3; y++) {
                            if ('"' + $scope.currentBoard[x][y]['id'] + '"' === data) {
                                $scope.currentBoard[x][y]['state'] = 'O'
                            }
                        }
                    }
                })
            }

}]);
