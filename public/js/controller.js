app.controller('MainController', ["$scope", "$http", function($scope, $http) {

    $scope.currentBoard = [[{id: 'A1', state: '?'}, {id: 'A2', state: '?'}, {id: 'A3', state: '?'}],
                           [{id: 'B1', state: '?'}, {id: 'B2', state: '?'}, {id: 'B3', state: '?'}],
                           [{id: 'C1', state: '?'}, {id: 'C2', state: '?'}, {id: 'C3', state: '?'}]]

    $scope.toX = function(currentCell) {
        if (currentCell.state === '?') {
            console.log(currentCell)
            currentCell.state = 'X'
        }
        $scope.toO
    }

    $scope.toO = function() {

    }

    // $scope.setClass = function(currentCell) {
    //     if (currentCell.x) {
    //         return 'x'
    //     }
    //     else if (currentCell.o) {
    //         return 'o'
    //     }
    //     else {
    //         return 'emptyCell'
    //     }
    // }

}]);
