app.controller('MainController', ["$scope", "$http", function($scope, $http) {

    $scope.currentBoard = [[{id: 'A1', state: '?'}, {id: 'A2', state: '?'}, {id: 'A3', state: '?'}],
                           [{id: 'B1', state: '?'}, {id: 'B2', state: '?'}, {id: 'B3', state: '?'}],
                           [{id: 'C1', state: '?'}, {id: 'C2', state: '?'}, {id: 'C3', state: '?'}]]

    $scope.winner = ''

    $scope.resetBoard = function() {
        $scope.currentBoard = [[{id: 'A1', state: '?'}, {id: 'A2', state: '?'}, {id: 'A3', state: '?'}],
                              [{id: 'B1', state: '?'}, {id: 'B2', state: '?'}, {id: 'B3', state: '?'}],
                              [{id: 'C1', state: '?'}, {id: 'C2', state: '?'}, {id: 'C3', state: '?'}]]
        $scope.winner = ''
    }    

    $scope.toX = function(currentCell) {
        if (currentCell.state == '?' && $scope.winner == '') {
            currentCell.state = 'X'
            nextMove()
        }
    }

    $scope.dynamicTitle = function() {
        if ($scope.winner == '') {
            return "Tic Tac Toe!"
        }
        else if ($scope.winner == 'COMP') {
            return "Computer Wins!!!"
        }
        else if ($scope.winner == 'DRAW') {
                return "Draw. How about a nice game of chess?"
        }
        else if ($scope.winner == 'USER') {
            return "Ooops!"
        }
    }

    // Ajax call to 
    var nextMove = function() {
        $http.post('/next_move',
                   $scope.currentBoard)
                   .success(function(data) {
                        $scope.currentBoard = data['board']
                        $scope.winner = data['winner']
                })
            }

}]);
