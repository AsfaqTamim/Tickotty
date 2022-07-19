var App = angular.module("App", [
    "ngRoute",
    "ngCookies",
    "ngSanitize",
    "ngMaterial",
    "ngMessages",
    "angular.filter",
    "currencyFormat",
    "ui.bootstrap",
    "app.utils",
    "tb-color-picker",
    "pascalprecht.translate",
    "angularFileUpload",
    "relativeDate",
    "xeditable",
    "ngQuill",
    "ui.tree",
    "toastr",
    "tmh.dynamicLocale"
]);

App.config(function($routeProvider, $mdThemingProvider, $translateProvider, $httpProvider, toastrConfig, tmhDynamicLocaleProvider) {
    "use strict";
    $routeProvider
        .when('/', {
            controller: 'Home',
            templateUrl: "assets/views/home/index.html",
        })
        .when("/article/:id", {
            controller: 'Article',
            templateUrl: "assets/views/home/article.html",
        })
        .when('/login', {
            controller: 'Login',
            templateUrl: "assets/views/login/login.html",
        })
        .when('/register', {
            controller: 'Login',
            templateUrl: "assets/views/login/register.html",
        })
        .otherwise({
            redirectTo: '/'
        })
        .when('/forgot', {
            controller: 'Login',
            templateUrl: "assets/views/login/forgot.html",
        })
        .when("/reset-password/:id", {
            controller: 'Login',
            templateUrl: "assets/views/login/reset-password.html",
        })
        .when("/dashboard", {
            templateUrl: "assets/views/dashboard/index.html",
            controller: "Dashboard",
        })
        .when("/clients", {
            templateUrl: "assets/views/clients/index.html",
            controller: "Clients",
        })
        .when("/clients/client/:id", {
            templateUrl: "assets/views/clients/client.html",
            controller: "Client",
        })
        .when("/clients/edit/:id", {
            templateUrl: "assets/views/staff/edit.html",
            controller: "Staff"
        })
        .otherwise({
            redirectTo: "/clients"
        })
        .when("/tickets", {
            templateUrl: "assets/views/tickets/index.html",
            controller: "Tickets",
        })
        .when("/tickets/create", {
            templateUrl: "assets/views/tickets/create.html",
            controller: "Tickets",
        })
        .when("/tickets/ticket/:id", {
            templateUrl: "assets/views/tickets/ticket.html",
            controller: "Ticket",
        })
        .otherwise({
            redirectTo: "/tickets"
        })
        .when("/reports", {
            templateUrl: "assets/views/reports/index.html",
            controller: "Reports",
        })
        .when("/knowledge-base", {
            templateUrl: "assets/views/knowledge-base/index.html",
            controller: "Knowledge",
        })
        .when("/knowledge-base/new-article", {
            templateUrl: "assets/views/knowledge-base/new-article.html",
            controller: "Knowledge",
        })
        .when("/knowledge-base/article/edit/:id", {
            templateUrl: "assets/views/knowledge-base/edit.html",
            controller: "Knowledge",
        })
        .when("/options", {
            templateUrl: "assets/views/options/index.html",
            controller: "Options",
        })
        .when("/options/general", {
            templateUrl: "assets/views/options/general.html",
            controller: "Options",
        })
        .when("/options/email", {
            templateUrl: "assets/views/options/email.html",
            controller: "Options",
        })
        .when("/options/departments", {
            templateUrl: "assets/views/options/departments.html",
            controller: "Options",
        })
        .when("/options/processes", {
            templateUrl: "assets/views/options/processes.html",
            controller: "Options",
        })
        .when("/options/custom-fields", {
            templateUrl: "assets/views/options/custom-fields.html",
            controller: "Options",
        })
        .when("/options/cron-jobs", {
            templateUrl: "assets/views/options/cron.html",
            controller: "Options",
        })
        .when("/options/business-hours", {
            templateUrl: "assets/views/options/business-hours.html",
            controller: "Options",
        })
        .otherwise({
            redirectTo: "/options"
        })
        .when("/staff", {
            templateUrl: "assets/views/staff/index.html",
            controller: "Staff",
        })
        .when("/staff/:id", {
            templateUrl: "assets/views/staff/staff.html",
            controller: "Staff"
        })
        .when("/staff/edit/:id", {
            templateUrl: "assets/views/staff/edit.html",
            controller: "Staff"
        })
        .when("/user/:id", {
            templateUrl: "assets/views/staff/staff.html",
            controller: "Staff"
        })
        .otherwise({
            redirectTo: "/staff"
        })
        .when("/sla", {
            templateUrl: "assets/views/sla/index.html",
            controller: "Sla",
        })
        .when("/sla/policy/:id", {
            templateUrl: "assets/views/sla/policy.html",
            controller: "Policy"
        })
        .when("/profile", {
            templateUrl: "assets/views/profile/index.html",
            controller: "Profile"
        })
        .when("/profile/edit", {
            templateUrl: "assets/views/profile/edit.html",
            controller: "Profile"
        })
        .otherwise({
            redirectTo: "/"
        })

    $mdThemingProvider
        .theme("default")
        .primaryPalette("grey")
        .accentPalette("blue-grey");
    $translateProvider.registerAvailableLanguageKeys(['en_US', 'nl_NL', 'ru_RU', 'tr_TR'], {
        'en_US': 'en_US',
        'nl_NL': 'nl_NL',
        'ru_RU': 'ru_RU',
        'tr_TR': 'tr_TR',
        'en': 'en_US',
        'nl': 'nl_NL',
        'ru': 'ru_RU',
        'tr': 'tr_TR'

    });

    $translateProvider.useStaticFilesLoader({
        prefix: 'assets/translations/lang_',
        suffix: '.json'
    });


    $translateProvider.preferredLanguage('en_US');
    $translateProvider.useCookieStorage();
    $translateProvider.fallbackLanguage("en_US");
    $translateProvider.useSanitizeValueStrategy('escape')
        .useMissingTranslationHandlerLog();

    tmhDynamicLocaleProvider.localeLocationPattern('assets/translations/i18n/angular-locale_{{locale}}.js');


    $httpProvider.interceptors.push('AuthInterceptor')

    angular.extend(toastrConfig, {
        allowHtml: false,
        closeButton: false,
        closeHtml: '<button>&times;</button>',
        extendedTimeOut: 1000,
        iconClasses: {
            error: 'toast-error',
            info: 'toast-info',
            success: 'toast-success',
            warning: 'toast-warning'
        },
        messageClass: 'toast-message',
        onHidden: null,
        onShown: null,
        onTap: null,
        progressBar: false,
        tapToDismiss: true,
        templates: {
            toast: 'directives/toast/toast.html',
            progressbar: 'directives/progressbar/progressbar.html'
        },
        timeOut: 5000,
        titleClass: 'toast-title',
        toastClass: 'toast'
    });
});

App.run(['$rootScope', '$location', '$cookieStore', '$http', '$window', 'tmhDynamicLocale',
    function($rootScope, $location, $cookieStore, $http, $window, tmhDynamicLocale) {
        $rootScope.LOGGED_IN = $cookieStore.get('LOGGED_IN') || {};
        if ($rootScope.LOGGED_IN.CURRENT_USER) {
            $http.defaults.headers.common['Authorization'] = 'Basic ' + $rootScope.LOGGED_IN.CURRENT_USER.AUTH_DATA;
        }
        /*$rootScope.$on("$routeChangeStart", function(event, next, current) {
            var restrictedPage = $.inArray($location.path(), ['/login', '/register', '/article/']) === -1;
            if (restrictedPage && !$rootScope.LOGGED_IN.CURRENT_USER) {
                $location.path('/');
            }
        });*/

        $http.get(APP_URL + "auth/GET_OPTIONS").then(function(OPTIONS) {
            $rootScope.OPTIONS = OPTIONS.data;
            $rootScope.PAGE_TITLE = $rootScope.OPTIONS.APPLICATION_NAME;
            tmhDynamicLocale.set($rootScope.OPTIONS.LANG);
            $rootScope.APPLICATION_NAME = $rootScope.OPTIONS.APPLICATION_NAME;
            $rootScope.MAX_PAGE_SIZE = $rootScope.OPTIONS.MAX_PAGE_SIZE;
        });

        $http.get(APP_URL + "auth/GET_APP_COLORS").then(function(COLORS) {
            $rootScope.COLORS = COLORS.data;
            document.body.style.setProperty('--primary-color', $rootScope.COLORS.PRIMARY_COLOR);
            document.body.style.setProperty('--secondary-color', $rootScope.COLORS.SECONDARY_COLOR);
            document.body.style.setProperty('--tertiary-color', $rootScope.COLORS.TERTIARY_COLOR);
            document.body.style.setProperty('--fourth-color', $rootScope.COLORS.FOURTH_COLOR);
            $rootScope.color = $rootScope.COLORS.PRIMARY_COLOR;
            $rootScope.AVATAR_COLOR = $rootScope.COLORS.PRIMARY_COLOR.substring(1);
        });

        $http.get('system.txt').then(
            function(response) {
                //console.log('get', response)
            },
            function(data) {
                if (data.status == 401) {
                    //
                }
                if (data.status == 402) {
                    //
                }
                if (data.status == 403) {
                    $window.location.href = APP_URL + 'install';
                }
                if (data.status == 404) {
                    $window.location.href = APP_URL + 'install';
                }
            })
    }
]);

App.controller('Header', function($rootScope, $location, $cookieStore, $scope, $q, $http, $window, $interval) {
    $rootScope.LOGGED_IN = $cookieStore.get('LOGGED_IN') || {};
    if ($rootScope.LOGGED_IN.CURRENT_USER) {
        $rootScope.AUTH_CHECK = true;
    } else {
        $rootScope.AUTH_CHECK = false;
    }
    $scope.MODE_COLOR = function() {
        $scope.DARK_MODE = !$scope.DARK_MODE;
    }
    $scope.TRICK_TOGGLE = function() {
        $scope.SIDE_TOGGLE = !$scope.SIDE_TOGGLE;
    }

    $scope.SCREEN_WIDTH_CAL = function() {
        $scope.SCREEN_WIDTH = Math.max(document.documentElement.clientWidth, window.innerWidth || 0)
    };
    $interval($scope.SCREEN_WIDTH_CAL, 100);
    $scope.$watch('SCREEN_WIDTH', function() {
        if ($scope.SCREEN_WIDTH < 1024) {
            $scope.SIDE_TOGGLE = true;
            $scope.SIDE_TOGGLE_STATUS = false;
        }
        if ($scope.SCREEN_WIDTH < 767) {
            $scope.SIDE_TOGGLE = false;
            $scope.SIDE_TOGGLE_STATUS = false;
        }
        if ($scope.SCREEN_WIDTH >= 1024) {
            $scope.SIDE_TOGGLE = false;
            $scope.SIDE_TOGGLE_STATUS = true;
        }
    });
});


App.controller('Home', function($rootScope, $location, $cookieStore, $scope, $http, $routeParams, $filter) {
    $rootScope.PAGE_TITLE = $filter('translate')('Knowledge_Base') + ' | ' + $rootScope.APPLICATION_NAME;
    $rootScope.LOGGED_IN = $cookieStore.get('LOGGED_IN') || {};

    $scope.GO_PATH = function(GO_PATH) {
        $location.path(GO_PATH);
    };

    $scope.MODE_COLOR = function() {
        $scope.DARK_MODE = !$scope.DARK_MODE;
    }

    $http.get(APP_URL + "home/GET_ARTICLE_CATEGORIES/").then(function(ARTICLE_CATEGORIES) {
        $scope.ARTICLE_CATEGORIES = ARTICLE_CATEGORIES.data;
    });

    $scope.GET_SEARCH_RESULT = function() {
        var dataObj = $.param({
            KEY: $scope.SEARCH_KEY
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'home/SEARCH_ARTICLE', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.SEARCH_RESULTS = RESPONSE.data;
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

});

App.controller('Article', function($rootScope, $location, $cookieStore, toastr, $filter, $scope, $http, $routeParams) {
    if ($routeParams.id) {

        $http.get(APP_URL + "home/GET_ARTICLE/" + $routeParams.id).then(function(ARTICLE) {
            $scope.ARTICLE = ARTICLE.data;
            $rootScope.PAGE_TITLE = $scope.ARTICLE.TITLE + ' | ' + $rootScope.APPLICATION_NAME;

            $http.get(APP_URL + "home/GET_CATEGORY_ARTICLES/" + $scope.ARTICLE.CATEGORY.ID).then(function(CATEGORY_ARTICLES) {
                $scope.CATEGORY_ARTICLES = CATEGORY_ARTICLES.data;
            });
        });

        $scope.VOTE_ARTICLE = function(VOTE) {
            var dataObj = $.param({
                ID: $scope.ARTICLE.ID,
                VOTE: VOTE,
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            if ($rootScope.AUTH_CHECK) {
                $http.post(APP_URL + 'home/VOTE_ARTICLE', dataObj, config)
                    .then(
                        function(RESPONSE) {
                            console.log(RESPONSE);
                            if (RESPONSE.data == 'true') {
                                if (VOTE == 1) {
                                    $scope.ARTICLE.TOTAL_UPVOTE += 1
                                }
                                $scope.ARTICLE.TOTAL_VOTES += 1
                            } else {
                                toastr.error($filter('translate')('NOTIFICATION_ALREADY_VOTED_TEXT'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                            }
                        },
                        function(RESPONSE) {
                            console.log(RESPONSE);
                        }
                    );
            } else {
                toastr.error($filter('translate')('NOTIFICATION_LOGIN_FOR_VOTE_TEXT'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
            }
        }
    }

    $scope.GO_PATH = function(GO_PATH) {
        $location.path(GO_PATH);
    };
    $scope.MODE_COLOR = function() {
        $scope.DARK_MODE = !$scope.DARK_MODE;
    }
    $http.get(APP_URL + "home/GET_ARTICLE_CATEGORIES/").then(function(ARTICLE_CATEGORIES) {
        $scope.ARTICLE_CATEGORIES = ARTICLE_CATEGORIES.data;
    });
    $scope.GET_SEARCH_RESULT = function() {
        var dataObj = $.param({
            KEY: $scope.SEARCH_KEY
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'home/SEARCH_ARTICLE', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.SEARCH_RESULTS = RESPONSE.data;
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }
});

App.controller("Sidebar", function($scope, $http, $scope, $rootScope, $cacheFactory, $window, $interval) {

    $scope.LEFT_MENU_CACHE = $http({
        url: APP_URL + "api/GET_LEFT_MENU",
        method: "GET",
        cache: true
    }).then(function(response) {
        $scope.LEFT_MENU = response.data;
        $scope.info = $cacheFactory.info();
        $scope.value = $cacheFactory.get('$http').get(APP_URL + "api/GET_LEFT_MENU")[1];
        $scope.typeOf = typeof $scope.value;
    });

    $rootScope.COLOR_OPTIONS = ['#7fc349', '#00ac5f', '#2275bc', '#133441', '#dc1c4b', '#1f8b95', '#ec7523', '#27374a', '#5e78bc', '#3F51B5'];

    $scope.colorChanged = function(newColor, oldColor) {
        console.log('from ', oldColor, ' to ', newColor);
        var dataObj = $.param({
            COLOR: newColor,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/CHANGE_COLOR', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.RESPONSE = RESPONSE.data;
                    document.body.style.setProperty('--primary-color', $scope.RESPONSE.PRIMARY_COLOR);
                    document.body.style.setProperty('--secondary-color', $scope.RESPONSE.SECONDARY_COLOR);
                    document.body.style.setProperty('--tertiary-color', $scope.RESPONSE.TERTIARY_COLOR);
                    document.body.style.setProperty('--fourth-color', $scope.RESPONSE.FOURTH_COLOR);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }
});

App.controller('Login', ['$scope', '$http', '$timeout', '$rootScope', '$location', 'AuthenticationService', 'toastr', '$routeParams', '$filter', function($scope, $http, $timeout, $rootScope, $location, AuthenticationService, toastr, $routeParams, $filter) {

    $scope.LOGIN = function() {
        $scope.dataLoading = true;
        AuthenticationService.Login($scope.USERNAME, $scope.PASSWORD, function(response) {
            if (response.data) {
                AuthenticationService.SetCredentials($scope.USERNAME, $scope.PASSWORD);
                $location.path('/');
                $rootScope.AUTH_CHECK = true;
            } else {
                toastr.error($filter('translate')('PROBLEM_NOTIFICATION_TEXT'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                $scope.dataLoading = false;
            }
        });
    };

    $scope.GO_PATH = function(GO_PATH) {
        $location.path(GO_PATH);
    };

    $scope.NEW_USER = {
        STAFF: false,
        ADMIN: false,
        PRIVILEGES: [{
                "ID": "1",
                "NAME": $filter('translate')('Clients'),
                "VALUE": false
            },
            {
                "ID": "2",
                "NAME": $filter('translate')('Tickets'),
                "VALUE": true
            },
            {
                "ID": "3",
                "NAME": $filter('translate')('Reports'),
                "VALUE": false
            },
            {
                "ID": "4",
                "NAME": $filter('translate')('Options'),
                "VALUE": false
            },
            {
                "ID": "5",
                "NAME": $filter('translate')('Staff'),
                "VALUE": true
            },
            {
                "ID": "6",
                "NAME": $filter('translate')('SLA'),
                "VALUE": false
            },
            {
                "ID": "6",
                "NAME": $filter('translate')('Knowledge_Base'),
                "VALUE": false
            }
        ]
    }

    $scope.REGISTER = function() {
        var dataObj = $.param({
            NAME: $scope.NEW_USER.NAME,
            SURNAME: $scope.NEW_USER.SURNAME,
            EMAIL: $scope.NEW_USER.EMAIL,
            PASSWORD: $scope.NEW_USER.PASSWORD,
            PRIVILEGES: JSON.stringify($scope.NEW_USER.PRIVILEGES),
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'auth/CREATE_ACCOUNT', dataObj, config)
            .then(
                function(RESPONSE) {
                    $scope.COMPLETE = true;
                    $scope.dataLoading = true;
                    AuthenticationService.Login($scope.NEW_USER.EMAIL, $scope.NEW_USER.PASSWORD, function(response) {
                        if (response.data) {
                            AuthenticationService.SetCredentials($scope.NEW_USER.EMAIL, $scope.NEW_USER.PASSWORD);
                            $location.path('/');
                            $rootScope.AUTH_CHECK = true;
                        } else {
                            toastr.error($filter('translate')('PROBLEM_NOTIFICATION_TEXT'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                            $scope.dataLoading = false;
                        }
                    });
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.RETURN_SUCCESS_MESSAGE = false;

    $scope.FORGOT_PASSWORD = function() {
        var dataObj = $.param({
            EMAIL: $scope.FORGOT_EMAIL,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'auth/FORGOT_PASSWORD', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE.data);
                    if (RESPONSE.data == 1) {
                        toastr.success($filter('translate')('FORGOT_SUCCESS_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                        $scope.RETURN_SUCCESS_MESSAGE = true;
                    }
                    if (RESPONSE.data == 2) {
                        toastr.error($filter('translate')('FORGOT_ERROR_NOTIFICATION_TEXT_ONE'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                    }
                    if (RESPONSE.data == 3) {
                        toastr.error($filter('translate')('FORGOT_ERROR_NOTIFICATION_TEXT_TWO'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                    }
                    if (RESPONSE.data == 4) {
                        toastr.error($filter('translate')('FORGOT_ERROR_NOTIFICATION_TEXT_THREE'), $filter('translate')('ERROR_NOTIFICATION_TEXT'));
                    }
                    if (RESPONSE.data == 5) {
                        toastr.error($filter('translate')('FORGOT_ERROR_NOTIFICATION_TEXT_FOUR'), $filter('translate')('ERROR_NOTIFICATION_TEXT'));
                    }
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    if ($routeParams.id) {
        $scope.RESET_PASSWORD = function() {
            var dataObj = $.param({
                TOKEN: $routeParams.id,
                password: $scope.NEW_PASSWORD,
                passconf: $scope.NEW_PASSWORD_CONF,
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'auth/RESET_PASSWORD', dataObj, config)
                .then(
                    function(RESPONSE) {
                        console.log(RESPONSE.data);
                    },
                    function(RESPONSE) {
                        console.log(RESPONSE);
                    }
                );
        }
    }

}]);

App.controller("Logs", function($rootScope, $http) {

    $http.get(APP_URL + "api/GET_LATEST_LOGS").then(function(LOGS) {
        $rootScope.LATEST_LOGS = LOGS.data;
    });

});

App.controller("Todo", function($scope, $http, $filter) {

    $http.get(APP_URL + "api/GET_ALL_TODOS").then(function(ENTERED_ALL_TODOS) {
        $scope.ENTERED_ALL_TODOS = ENTERED_ALL_TODOS.data;
        $scope.ALL_TODOS = $filter('filter')($scope.ENTERED_ALL_TODOS, {
            DONE: false,
        });
        $scope.COMPLETED_TODOS = $filter('filter')($scope.ENTERED_ALL_TODOS, {
            DONE: true,
        });

        $scope.CREATE_TODO = function() {
            var dataObj = $.param({
                DETAIL: $scope.newTitle
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'api/CREATE_TODO', dataObj, config)
                .then(
                    function(RESPONSE) {
                        console.log(RESPONSE);
                        var TODO = [];
                        $scope.ALL_TODOS.unshift({
                            DETAIL: $scope.newTitle,
                        });
                        $scope.newTitle = "";
                    },
                    function(RESPONSE) {
                        console.log(RESPONSE);
                    }
                );
        }

        $scope.REMOVE_TODO = function(index) {
            var TODO = $scope.ALL_TODOS[index];
            var dataObj = $.param({
                ID: TODO.ID
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'api/REMOVE_TODO', dataObj, config)
                .then(
                    function(RESPONSE) {
                        console.log(RESPONSE);
                        $scope.ALL_TODOS.splice($scope.ALL_TODOS.indexOf(TODO), 1);
                    },
                    function(RESPONSE) {
                        console.log(RESPONSE);
                    }
                );
        }

        $scope.MARK_AS_TODO_DONE = function(index) {
            var TODO = $scope.ALL_TODOS[index];
            var dataObj = $.param({
                ID: TODO.ID
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'api/MARK_AS_TODO_DONE', dataObj, config)
                .then(
                    function(RESPONSE) {
                        console.log(RESPONSE);
                        TODO.DONE = true;
                        $scope.ALL_TODOS.splice($scope.ALL_TODOS.indexOf(TODO), 1);
                        $scope.COMPLETED_TODOS.unshift(TODO);
                    },
                    function(RESPONSE) {
                        console.log(RESPONSE);
                    }
                );
        }

        $scope.UNMARK_AS_TODO_DONE = function(index) {
            var TODO = $scope.COMPLETED_TODOS[index];
            var dataObj = $.param({
                ID: TODO.ID
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'api/UNMARK_AS_TODO_DONE', dataObj, config)
                .then(
                    function(RESPONSE) {
                        console.log(RESPONSE);
                        $scope.COMPLETED_TODOS.splice($scope.COMPLETED_TODOS.indexOf(TODO), 1);
                        $scope.ALL_TODOS.unshift(TODO);
                    },
                    function(RESPONSE) {
                        console.log(RESPONSE);
                    }
                );
        }

        $scope.TOTAL_TODO_COUNT = function() {
            return $scope.ALL_TODOS.length + $scope.COMPLETED_TODOS.length;
        };

        $scope.TODO_COMPLETION_TOTAL = function(UNIT) {
            var TOTAL = $scope.TOTAL_TODO_COUNT();
            if (TOTAL) {
                return Math.floor((100 / TOTAL) * UNIT);
            } else {
                return 0;
            }

        };
    });
});

App.controller("Notifications", function($scope, $http, $filter) {

    $http.get(APP_URL + "api/GET_USER_NOTIFICATIONS").then(function(NTF) {
        $scope.NOTIFICATIONS = NTF.data;
        $scope.HAS_UNREAD_NOTIFICATION = $filter('filter')($scope.NOTIFICATIONS, {
            READ: false
        })
    });

    $scope.MARK_NOTIFICATION_AS_READ = function(NTF_ID) {
        var dataObj = $.param({
            NTF_ID: NTF_ID,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/MARK_NOTIFICATION_AS_READ', dataObj, config)
            .then(
                function(response) {
                    console.log(response);
                },
                function(response) {
                    console.log(response);
                }
            );
    };

    $scope.MARK_NOTIFICATION_AS_ALL_READ = function() {
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/MARK_NOTIFICATION_AS_ALL_READ', config)
            .then(
                function(response) {
                    console.log(response);
                },
                function(response) {
                    console.log(response);
                }
            );
    };
});

App.controller("Master", function($scope, $http, $interval, $location, $mdSidenav, $cookies, $cacheFactory, $rootScope, toastr, $translate, FileUploader, $filter, $window, AuthenticationService, tmhDynamicLocale) {

    "use strict";
    $rootScope.APP_URL = APP_URL;

    $http.get(APP_URL + "auth/GET_USER_INFO").then(function(USER) {
        $rootScope.USER = USER.data;
        tmhDynamicLocale.set($rootScope.USER.LANGUAGE);
        $translate.use($rootScope.USER.LANGUAGE);
        $rootScope.USER_PERMISSIONS = USER.data.PERMISSIONS;
        $scope.SHOW_RIGHT_NAVBAR = true;
        if ($rootScope.USER != 'false') {
            $rootScope.USER_LOGGED_IN = 'true';
        } else {
            $rootScope.USER_LOGGED_IN = 'false';
        }
    });

    $scope.DATE = new Date();
    $scope.TICK = function() {
        $scope.CLOCK = Date.now();
    };

    $scope.TICK();
    $interval($scope.TICK, 1000);

    $scope.cur_symbol = "USD";
    $scope.cur_code = "USD";
    $scope.cur_lct = "en_US";

    // Uploader 

    var uploader = $scope.uploader = new FileUploader({
        url: APP_URL + "api/UPLOAD_ATTACHMENT",
        //,timeout: 2000
    });

    // a sync filter
    uploader.filters.push({
        name: 'syncFilter',
        fn: function(item /*{File|FileLikeObject}*/ , options) {
            console.log('syncFilter');
            return this.queue.length < 10;
        }
    });

    // an async filter
    uploader.filters.push({
        name: 'asyncFilter',
        fn: function(item /*{File|FileLikeObject}*/ , options, deferred) {
            console.log('asyncFilter');
            setTimeout(deferred.resolve, 1e3);
        }
    });

    // CALLBACKS

    $scope.UPLOADED_ATTACHMENT = []

    uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/ , filter, options) {
        console.info('onWhenAddingFileFailed', item, filter, options);
    };
    uploader.onAfterAddingFile = function(fileItem) {
        console.info('onAfterAddingFile', fileItem);
    };
    uploader.onAfterAddingAll = function(addedFileItems) {
        console.info('onAfterAddingAll', addedFileItems);
    };
    uploader.onBeforeUploadItem = function(item) {
        console.info('onBeforeUploadItem', item);
    };
    uploader.onProgressItem = function(fileItem, progress) {
        console.info('onProgressItem', fileItem, progress);
    };
    uploader.onProgressAll = function(progress) {
        console.info('onProgressAll', progress);
    };
    uploader.onSuccessItem = function(fileItem, response, status, headers) {
        console.info('onSuccessItem', fileItem, response, status, headers);
        $scope.UPLOADED_ATTACHMENT.push(response);
    };
    uploader.onErrorItem = function(fileItem, response, status, headers) {
        console.info('onErrorItem', fileItem, response, status, headers);
    };
    uploader.onCancelItem = function(fileItem, response, status, headers) {
        console.info('onCancelItem', fileItem, response, status, headers);
    };
    uploader.onCompleteItem = function(fileItem, response, status, headers) {
        console.info('onCompleteItem', fileItem, response, status, headers);
    };

    uploader.onTimeoutItem = function(fileItem) {
        console.info('onTimeoutItem', fileItem);
    };

    uploader.onCompleteAll = function() {
        console.info('onCompleteAll');
    };

    $scope.$watch(' uploader.queue.length', function() {
        $scope.uploader.uploadAll()
    });

    //UPLOADER

    $scope.GO_PATH = function(GO_PATH) {
        $location.path(GO_PATH);
    };

    $scope.GO_TICKET = function(TOKEN) {
        $location.path('tickets/ticket/' + TOKEN);
    };

    $scope.CHANGE_LANGUAGE = function(key) {
        $translate.use(key);
        tmhDynamicLocale.set(key);
        var dataObj = $.param({
            KEY: key,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/UPDATE_USER_LANGUAGE', dataObj, config)
            .then(
                function(RESPONSE) {},
                function(RESPONSE) {}
            );
    };

    $rootScope.$on('$routeChangeSuccess', function() {
        $scope.SELECTED_USER = false;
    });

    $http.get(APP_URL + "api/GET_STATS").then(function(STATS) {
        $rootScope.STATS = STATS.data;
    });

    $http.get(APP_URL + "api/GET_DEPARTMENTS").then(function(DEPARTMENTS) {
        $rootScope.DEPARTMENTS = DEPARTMENTS.data;
    });

    $scope.Create = BULD_TOGGLER("Create");

    function BULD_TOGGLER(navID) {
        return function() {
            $mdSidenav(navID).toggle();
        };
    }

    $scope.CLOSE = function() {
        $mdSidenav("Create").close();
    };

    $scope.SELECT_ATTACHMENT = function() {
        $("input[type=file]").click();
    };


    $scope.NEW_TICKET = {
        DEPARTMENT: 1,
        PRIORITY: 1,
    }

    $scope.TMP_UPLOADS = [];
    $scope.progressCounter = 0;
    $scope.FILE_IS_UPLOADING = false;
    $scope.UPLOAD_ATTACHMENT = function() {
        $scope.FILE_IS_UPLOADING = true;
        var fd = new FormData();
        angular.forEach($scope.uploadfiles, function(file) {
            fd.append('file[]', file);
        });
        $http({
            method: "post",
            url: APP_URL + "api/UPLOAD_ATTACHMENT",
            data: fd,
            uploadEventHandlers: {
                progress: function(e) {
                    if (e.lengthComputable) {
                        $scope.progressBar = (e.loaded / e.total) * 100;
                        $scope.progressCounter = $scope.progressBar.toFixed(2);
                        console.log($scope.progressCounter);
                    }
                }
            },
            headers: {
                "Content-Type": undefined
            },
        }).then(function successCallback(UPLOADED_ATTACHMENT) {
            $scope.UPLOADED_ATTACHMENT = UPLOADED_ATTACHMENT.data;
            $scope.TMP_UPLOADS.push($scope.UPLOADED_ATTACHMENT);
            $scope.FILE_IS_UPLOADING = false;
            $("input[type=file]").val('');
        });
    };


    $scope.UPLOAD_TICKET_ATTACHMENT = function() {
        $scope.FILE_IS_UPLOADING = true;
        var fd = new FormData();
        var files = document.getElementById("ATTACHMENT").files[0];
        fd.append("file", files);
        $http({
            method: "post",
            url: APP_URL + "api/UPLOAD_ATTACHMENT",
            data: fd,
            uploadEventHandlers: {
                progress: function(e) {
                    if (e.lengthComputable) {
                        $scope.progressBar = (e.loaded / e.total) * 100;
                        $scope.progressCounter = $scope.progressBar.toFixed(2);
                        console.log($scope.progressCounter);
                    }
                }
            },
            headers: {
                "Content-Type": undefined
            },
        }).then(function successCallback(UPLOADED_ATTACHMENT) {
            $scope.UPLOADED_ATTACHMENT = UPLOADED_ATTACHMENT.data;
            $scope.TMP_UPLOADS.push($scope.UPLOADED_ATTACHMENT);
            $scope.FILE_IS_UPLOADING = false;
            $("input[type=file]").val('');
        });
    };

    $scope.REMOVE_FILE = function(FILE) {
        var dataObj = $.param({
            FILE: FILE,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/REMOVE_FILE';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    if ($scope.TICKET) {
                        $scope.GET_TICKET_DETAIL();
                    }
                    if ($scope.TMP_UPLOADS) {
                        $scope.TMP_UPLOADS.splice($scope.TMP_UPLOADS.indexOf(FILE), 1);
                    }
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.DOWNLOAD_FILE = function(FILE) {
        $scope.FILE = FILE;
        var dataObj = $.param({
            FILE: FILE,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/DOWNLOAD_FILE';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $window.open(APP_URL + "../assets/uploads/ticket-attachments/" + $scope.FILE.FILE_NAME, "_new");
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.SELECT_USER = function(USER) {
        $scope.SELECTED_USER = USER;
        window.scrollTo(0, 0);
    };

    $scope.CLOSE_USER = function() {
        $scope.SELECTED_USER = false;
        window.scrollTo(0, 0);
    };

    $scope.LOGOUT = function() {
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + "auth/LOGOUT/";
        $http.post(posturl, config).then(
            function(response) {
                console.log(response);
                if (response.data) {
                    console.log(response);
                    $cookies.put('LOGGED_IN', null, {
                        path: '/'
                    });
                    $rootScope.AUTH_CHECK = false;
                    $cacheFactory.get('$http').removeAll();
                    $location.path('login');
                    AuthenticationService.ClearCredentials();
                }
                if (!response.data) {
                    console.log(response);
                    $cookies.put('LOGGED_IN', null, {
                        path: '/'
                    });
                    $location.path('login');
                }
            }
        );
        $location.path('login');
    };

});

App.controller('Dashboard', function($rootScope, $location, $cookieStore, $scope, $filter) {
    $rootScope.PAGE_TITLE = $filter('translate')('Dashboard') + ' | ' + $rootScope.APPLICATION_NAME;
});

App.controller("Clients", function($scope, $http, $filter, $rootScope, PrivilegeService) {
    "use strict";

    PrivilegeService.CHECK('clients');

    $rootScope.PAGE_TITLE = $filter('translate')('Clients') + ' | ' + $rootScope.APPLICATION_NAME;

    // Data fetch //
    $scope.FILTER = {
        NAME: '',
        INDEX: 1,
        MAX_SIZE: 6,
        SELECTED_PAGE_SIZE: 6,
    };

    $scope.RESET_FILTER = function() {
        $scope.FILTER = {
            NAME: '',
            INDEX: 1,
            MAX_SIZE: 6,
            SELECTED_PAGE_SIZE: 6,
        };
        $scope.GET_FILTERED_DATA();
    };

    $scope.TOTAL_COUNT = 0;

    $scope.GET_FILTERED_DATA = function() {
        $http({
            method: 'POST',
            url: APP_URL + "api/GET_CLIENTS",
            data: {
                LIMIT: $scope.FILTER.SELECTED_PAGE_SIZE,
                OFFSET: $scope.FILTER.INDEX,
                FILTER: {
                    NAME: $scope.FILTER.NAME,
                }
            },
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        }).then(function(response) {
            $scope.CLIENTS = response.data.CLIENTS;
            $scope.TOTAL_COUNT = response.data.TOTAL;
            $scope.ALL_TOTAL = response.data.ALL_TOTAL;
            $scope.PAGE_NUMBER = Math.ceil($scope.TOTAL_DATA / $scope.PAGE_SIZE);
        });
    };

    $scope.GET_FILTERED_DATA();

    $scope.PAGE_CHANGED = function(PAGE_INDEX) {
        $scope.GET_FILTERED_DATA(PAGE_INDEX);
    };
    $scope.CHANGE_PAGE_SIZE = function() {
        $scope.PAGE_INDEX = 1;
        $scope.GET_FILTERED_DATA();
    };
    // Data fetch //
});

App.controller("Client", function($scope, $http, $filter, $rootScope, $routeParams, PrivilegeService, $location) {
    "use strict";

    PrivilegeService.CHECK('clients');

    $rootScope.PAGE_TITLE = $filter('translate')('Client') + ' | ' + $rootScope.APPLICATION_NAME;

    $http.get(APP_URL + "api/GET_CLIENT/" + $routeParams.id).then(function(CLIENT) {
        $scope.CLIENT = CLIENT.data;
    });

    $scope.REMOVE_USER = function() {
        var dataObj = $.param({
            ID: $scope.CLIENT.ID,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/REMOVE_STAFF', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $location.path('/clients');
                    toastr.warning($filter('translate')('CLIENT_REMOVED_NOTIFICATION_TEXT'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                    //toastr.error('This action is not allowed in the demo version.',$filter('translate')('WARNING_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }
});

App.controller("Tickets", function($scope, $http, $filter, $location, $rootScope, toastr, $mdSidenav, PrivilegeService, FieldService, $translate) {
    "use strict";

    PrivilegeService.CHECK('tickets');

    $rootScope.PAGE_TITLE = $filter('translate')('Tickets') + ' | ' + $rootScope.APPLICATION_NAME;

    $http.get(APP_URL + "api/GET_DEPARTMENTS").then(function(DEPARTMENTS) {
        $rootScope.DEPARTMENTS = DEPARTMENTS.data;
    });

    $http.get(APP_URL + "api/GET_CATEGORIES").then(function(CATEGORIES) {
        $rootScope.CATEGORIES = CATEGORIES.data;
    });

    $http.get(APP_URL + "api/GET_ALL_STAFF").then(function(ALL_STAFF) {
        $scope.ALL_STAFF = ALL_STAFF.data;
    });


    $scope.HIDE_RIGHT_SIDEBAR = true;


    $scope.TICKET_STATUSES = [{
            ID: "1",
            NAME: $filter('translate')('Opened')
        },
        {
            ID: "2",
            NAME: $filter('translate')('Assigned')
        },
        {
            ID: "3",
            NAME: $filter('translate')('Replied')
        },
        {
            ID: "4",
            NAME: $filter('translate')('Closed')
        }
    ];


    $scope.TICKET_PRIORITIES = [{
            ID: "1",
            NAME: $filter('translate')('Low')
        },
        {
            ID: "2",
            NAME: $filter('translate')('Medium')
        },
        {
            ID: "3",
            NAME: $filter('translate')('High')
        }
    ];

    $scope.CUSTOM_TABLE_FIELDS = [{
            STATUS: false,
            NAME: "PRIORITY"
        },
        {
            STATUS: false,
            NAME: "PROCESS"
        },
        {
            STATUS: false,
            NAME: "CATEGORY"
        }
    ];

    $scope.CHANGE_ASSIGNATED_FILTER = function(VAL) {
        $scope.FILTER.ASSIGNATED = VAL;
    };

    $scope.ASSIGNEE_STATUS = 0;
    // Data fetch //
    $scope.FILTER = {
        KEYWORD: '',
        ASSIGNATED: false,
        STATUS: ["1", "2", "3"],
        PRIORITY: false,
        CATEGORY: false,
        DEPARTMENT: false,
        ORDER_BY_CLIENT: false,
        ORDER_BY_ID: false,
        ORDER_BY_DATE: false,
        ORDER_BY_ASSIGNED: false,
        ORDER_BY_STATUS: false,
        CREATED_DATE_START: null,
        CREATED_DATE_END: null,
        INDEX: 1,
        MAX_SIZE: 6,
        SELECTED_PAGE_SIZE: 6,
    };

    $scope.RESET_FILTER = function() {
        $scope.FILTER = {
            KEYWORD: '',
            ASSIGNATED: false,
            STATUS: false,
            PRIORITY: false,
            CATEGORY: false,
            DEPARTMENT: false,
            ORDER_BY_CLIENT: false,
            ORDER_BY_ID: false,
            ORDER_BY_DATE: false,
            ORDER_BY_ASSIGNED: false,
            ORDER_BY_STATUS: false,
            CREATED_DATE_START: null,
            CREATED_DATE_END: null,
            INDEX: 1,
            MAX_SIZE: 6,
            SELECTED_PAGE_SIZE: 6,
        };
        $scope.GET_FILTERED_DATA();
    };

    $scope.TOTAL_COUNT = 0;

    $scope.GET_FILTERED_DATA = function() {
        $http({
            method: 'POST',
            url: APP_URL + "api/GET_TICKETS",
            data: {
                LIMIT: $scope.FILTER.SELECTED_PAGE_SIZE,
                OFFSET: $scope.FILTER.INDEX,
                FILTER: {
                    KEYWORD: $scope.FILTER.KEYWORD,
                    ASSIGNATED: $scope.FILTER.ASSIGNATED,
                    STATUS: $scope.FILTER.STATUS,
                    PRIORITY: $scope.FILTER.PRIORITY,
                    CATEGORY: $scope.FILTER.CATEGORY,
                    DEPARTMENT: $scope.FILTER.DEPARTMENT,
                    ORDER_BY_CLIENT: $scope.FILTER.ORDER_BY_CLIENT,
                    ORDER_BY_ID: $scope.FILTER.ORDER_BY_ID,
                    ORDER_BY_DATE: $scope.FILTER.ORDER_BY_DATE,
                    ORDER_BY_ASSIGNED: $scope.FILTER.ORDER_BY_ASSIGNED,
                    ORDER_BY_STATUS: $scope.FILTER.ORDER_BY_STATUS,
                    CREATED_DATE_START: moment($scope.FILTER.CREATED_DATE_START).format("YYYY-MM-DD"),
                    CREATED_DATE_END: moment($scope.FILTER.CREATED_DATE_END).format("YYYY-MM-DD"),
                }
            },
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        }).then(function(response) {
            $scope.TICKETS = response.data.ENTRIES;
            $scope.TOTAL_COUNT = response.data.TOTAL;
            $scope.ALL_TOTAL = response.data.ALL_TOTAL;
            $scope.PAGE_NUMBER = Math.ceil($scope.TOTAL_DATA / $scope.PAGE_SIZE);
            //MULTIPLE ACTIONS
            $scope.SELECTED = [];

            $scope.TOGGLE_SOLIDARITY = function(item, list) {
                var idx = list.indexOf(item);
                if (idx > -1) {
                    list.splice(idx, 1);
                } else {
                    list.push(item);
                }
            };
            $scope.EXIST_SOLIDARITY = function(item, list) {
                return list.indexOf(item) > -1;
            };
            $scope.IS_INDETERMINATE_SOLIDARITY = function() {
                return ($scope.SELECTED.length !== 0 &&
                    $scope.SELECTED.length !== $scope.TICKETS.length);
            };
            $scope.IS_CHECKED_SOLIDARITY = function() {
                return $scope.SELECTED.length === $scope.TICKETS.length;
            };
            $scope.TOGGLE_ALL_SOLIDARITY = function() {
                if ($scope.SELECTED.length === $scope.TICKETS.length) {
                    $scope.SELECTED = [];
                } else if ($scope.SELECTED.length === 0 || $scope.SELECTED.length > 0) {
                    $scope.SELECTED = $scope.TICKETS.slice(0);
                }
            };
        });
    };

    $scope.GET_FILTERED_DATA();
    $scope.PAGE_CHANGED = function(PAGE_INDEX) {
        $scope.GET_FILTERED_DATA(PAGE_INDEX);
    };
    $scope.CHANGE_PAGE_SIZE = function() {
        $scope.PAGE_INDEX = 1;
        $scope.GET_FILTERED_DATA();
    };

    // Data fetch //

    FieldService.GET('TICKETS', function(response) {
        $rootScope.CUSTOM_FIELDS = response;

    });

    $rootScope.CHECK_FIELD_CONDITION = function(FIELD, PARENT) {
        $scope.PARENT_FIELD_S = $filter('filter')($scope.CUSTOM_FIELDS, function(value) {
            return value.ID === PARENT;
        });
        $scope.PARENT_FIELD = $scope.PARENT_FIELD_S[0]
        if (FIELD.ACTIVE) {
            if (FIELD.CONDITION.STATUS) {
                switch (FIELD.CONDITION.OPERATOR) {
                    case 1:
                        if (FIELD.CONDITION.VALUE.includes($scope.PARENT_FIELD.DATA) || FIELD.CONDITION.VALUE.includes($scope.PARENT_FIELD.SELECTED)) {
                            return true;
                        } else {
                            return false;
                        }
                    case 2:
                        if (!(FIELD.CONDITION.VALUE.includes($scope.PARENT_FIELD.DATA)) || !(FIELD.CONDITION.VALUE.includes($scope.PARENT_FIELD.SELECTED))) {
                            return true;
                        } else {
                            return false;
                        }
                    case 3:
                        if ($scope.PARENT_FIELD.DATA > FIELD.CONDITION.VALUE[0]) {
                            return true;
                        } else {
                            return false;
                        }
                    case 4:
                        if ($scope.PARENT_FIELD.DATA < FIELD.CONDITION.VALUE[0]) {
                            return true;
                        } else {
                            return false;
                        }
                }
            } else {
                return true;
            }
        } else {
            return false;
        }
    };

    //console.log($translate('CREATE_TICKET_LOG_MESSAGE', { user: $rootScope.USER.NAME }).then(function(TRANSLATED_TEXT) { console.log(TRANSLATED_TEXT); }));

    $scope.CREATE_TICKET = function() {
        var dataObj = $.param({
            SUBJECT: $scope.NEW_TICKET.SUBJECT,
            DETAIL: $scope.NEW_TICKET.DETAIL,
            PRIORITY: $scope.NEW_TICKET.PRIORITY,
            DEPARTMENT_ID: $scope.NEW_TICKET.DEPARTMENT,
            CATEGORY_ID: $scope.NEW_TICKET.CATEGORY_ID,
            ATTACHMENT: $scope.UPLOADED_ATTACHMENT,
            CUSTOM_FIELDS: JSON.stringify($scope.CUSTOM_FIELDS),
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/CREATE_TICKET';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $location.path('tickets/ticket/' + RESPONSE.data);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.ASSIGN_STAFF_TO_SELECTED_TICKET = function(STAFF_ID) {
        var dataObj = $.param({
            TICKETS: $scope.SELECTED,
            STAFF_ID: STAFF_ID,
        });
        var config = {
            headers: {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            }
        };
        $http.post(APP_URL + 'api/ASSIGN_STAFF_TO_SELECTED_TICKET/' + STAFF_ID, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    if (RESPONSE.data) {
                        $scope.GET_FILTERED_DATA();
                    }
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.SET_STATUS_TO = function(STATUS) {
        var dataObj = $.param({
            TICKETS: $scope.SELECTED,
            STATUS: STATUS,
        });
        var config = {
            headers: {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            }
        };
        $http.post(APP_URL + 'api/SET_STATUS_TO', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    if (RESPONSE.data) {
                        $scope.GET_FILTERED_DATA();
                    }
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.SET_STATUS_TO = function() {
        var dataObj = $.param({
            TICKETS: $scope.SELECTED,
            STATUS: $scope.SELECTED_STATUS_TO,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/SET_STATUS_TO';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_FILTERED_DATA();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.SET_PRIORITY_TO = function() {
        var dataObj = $.param({
            TICKETS: $scope.SELECTED,
            PRIORITY: $scope.SELECTED_PRIORITY_TO,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/SET_PRIORITY_TO';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_FILTERED_DATA();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.MARK_SELECTED_TICKETS_AS_SPAM = function() {
        var dataObj = $.param({
            TICKETS: $scope.SELECTED,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/MARK_SELECTED_TICKETS_AS_SPAM';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('TICKETS_MARKED_AS_SPAM_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.REMOVE_SELECTED_TICKETS_WARNING = function() {
        $scope.REMOVE = true;
    }

    $scope.MARK_SELECTED_TICKETS_AS_SPAM_WARNING = function() {
        $scope.CONFIRM = true;
    }

    $scope.REMOVE_SELECTED_TICKETS = function() {
        var dataObj = $.param({
            TICKETS: $scope.SELECTED,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/REMOVE_SELECTED_TICKETS';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_FILTERED_DATA();
                    toastr.success($filter('translate')('TICKETS_REMOVED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                    $scope.REMOVE = false;
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.MERGE = {
        "SHOW": false,
        "MERGE_THREADS": false,
        "PARENT_STATUS": "1",
        "CHILD_STATUS": "4"
    }

    $scope.TICKETS_TO_MERGE = [];

    $scope.MERGE_SELECTED_TICKETS = function() {
        $scope.MERGE.SHOW = true;
        $scope.TICKETS_TO_MERGE = $scope.SELECTED;
    }

    $scope.SEARCH_TICKET_FOR_MERGE = function() {
        var dataObj = $.param({
            KEY: $scope.SEARCH_KEY
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/SEARCH_TICKET_FOR_MERGE', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $http.get(APP_URL + "api/GET_TICKET_DETAIL/" + RESPONSE.data.TOKEN).then(function(TICKET) {
                        $scope.TICKET_FOUND = TICKET.data;
                    });
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.ADD_TO_MERGE = function() {
        $scope.TICKETS_TO_MERGE.push(
            $scope.TICKET_FOUND
        );
        for (var i = 0; i < $scope.TICKETS_TO_MERGE.length; i++) {
            $scope.TICKETS_TO_MERGE[i].ID = i.toString();
        }
        $scope.SEARCH_KEY = null;
    };

    $scope.REMOVE_FROM_MERGE_LIST = function(index) {
        $scope.TICKETS_TO_MERGE.splice(index, 1);
        $scope.PARENT_TICKET_TOKEN = null;
    };

    $scope.SELECT_PARENT_TICKET = function(ID) {
        $scope.PARENT_TICKET_TOKEN = ID;
    }

    $scope.START_MERGING = function() {
        var dataObj = $.param({
            TICKETS: $scope.SELECTED,
            MERGE_THREADS: $scope.MERGE.MERGE_THREADS,
            PARENT_STATUS: $scope.MERGE.PARENT_STATUS,
            CHILD_STATUS: $scope.MERGE.CHILD_STATUS,
            PARENT_TICKET_TOKEN: $scope.PARENT_TICKET_TOKEN,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/START_MERGING';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('TICKETS_MERGED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                    $scope.MERGE = {
                        "SHOW": false,
                        "MERGE_THREADS": false,
                        "PARENT_STATUS": "1",
                        "CHILD_STATUS": "4"
                    }
                    $scope.PARENT_TICKET_TOKEN = null;
                    $scope.GET_FILTERED_DATA();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

});

App.controller("Ticket", function($scope, $http, toastr, $routeParams, $rootScope, $location, $filter, $interval) {
    "use strict";

    $rootScope.PAGE_TITLE = $filter('translate')('Ticket') + ' | ' + $rootScope.APPLICATION_NAME;

    $scope.TICKET_PRIORITIES = [{
            ID: "1",
            NAME: $filter('translate')('Low')
        },
        {
            ID: "2",
            NAME: $filter('translate')('Medium')
        },
        {
            ID: "3",
            NAME: $filter('translate')('High')
        }
    ];

    $scope.TICKET_STATUSES = [{
            ID: "1",
            NAME: $filter('translate')('Opened')
        },
        {
            ID: "2",
            NAME: $filter('translate')('Assigned')
        },
        {
            ID: "3",
            NAME: $filter('translate')('Replied')
        },
        {
            ID: "4",
            NAME: $filter('translate')('Closed')
        }
    ];

    $http.get(APP_URL + "api/GET_PROCESSES").then(function(PROCESSES) {
        $rootScope.TICKET_PROCESS = PROCESSES.data;
    });

    $http.get(APP_URL + "api/GET_DEPARTMENTS").then(function(DEPARTMENTS) {
        $rootScope.DEPARTMENTS = DEPARTMENTS.data;
    });

    $http.get(APP_URL + "api/GET_ALL_STAFF").then(function(ALL_STAFF) {
        $scope.ALL_STAFF = ALL_STAFF.data;
    });

    $http.get(APP_URL + "api/GET_SLA_POLICIES").then(function(SLA_POLICIES) {
        $scope.SLA_POLICIES = SLA_POLICIES.data;
    });

    $rootScope.GET_TICKET_DETAIL = function() {
        $http.get(APP_URL + "api/GET_TICKET_DETAIL/" + $routeParams.id).then(function(TICKET) {
            $rootScope.TICKET = TICKET.data;
            if (TICKET.data.SLA) {
                var RESPOND_DUE = TICKET.data.SLA.RESPOND_DUE;
                var RESOLVE_DUE = TICKET.data.SLA.RESOLVE_DUE;
                if (new Date(RESPOND_DUE) >= new Date()) {
                    $scope.SHOW_RESPOND_DUE = true;
                }
                if (new Date(RESOLVE_DUE) >= new Date()) {
                    $scope.SHOW_RESOLVE_DUE = true;
                }
                $scope.RESPOND_DUE_TIMER = {
                    DAYS: 0,
                    HOURS: 0,
                    MINUTES: 0,
                    SECONDS: 0,
                    GET_RESPOND_DUE_TIME_REMAINING: function(RESPOND_DUE) {
                        var TOTAL = Date.parse(RESPOND_DUE) - Date.parse(new Date());
                        var SECONDS = Math.floor((TOTAL / 1000) % 60);
                        var MINUTES = Math.floor((TOTAL / 1000 / 60) % 60);
                        var HOURS = Math.floor((TOTAL / (1000 * 60 * 60)) % 24);
                        var DAYS = Math.floor(TOTAL / (1000 * 60 * 60 * 24));
                        return {
                            'TOTAL': TOTAL,
                            'DAYS': DAYS,
                            'HOURS': HOURS,
                            'MINUTES': MINUTES,
                            'SECONDS': SECONDS
                        };
                    },

                    INITIALIZE_RESPOND_DUE_CLOCK: function(RESPOND_DUE) {
                        function UPDATE_RESPOND_DUE_CLOCK() {
                            var TOTAL = $scope.RESPOND_DUE_TIMER.GET_RESPOND_DUE_TIME_REMAINING(RESPOND_DUE);
                            $scope.RESPOND_DUE_TIMER.DAYS = TOTAL.DAYS < 10 ? '0' + TOTAL.DAYS : TOTAL.DAYS;
                            $scope.RESPOND_DUE_TIMER.HOURS = ('0' + TOTAL.HOURS).slice(-2);
                            $scope.RESPOND_DUE_TIMER.MINUTES = ('0' + TOTAL.MINUTES).slice(-2);
                            $scope.RESPOND_DUE_TIMER.SECONDS = ('0' + TOTAL.SECONDS).slice(-2);
                            if (TOTAL.TOTAL <= 0) {
                                $interval.cancel(RESPOND_DUE_TIME_INTERVAL);
                            }
                        }

                        UPDATE_RESPOND_DUE_CLOCK();
                        var RESPOND_DUE_TIME_INTERVAL = $interval(UPDATE_RESPOND_DUE_CLOCK, 1000);
                    }
                }
                $scope.RESPOND_DUE_TIMER.INITIALIZE_RESPOND_DUE_CLOCK(RESPOND_DUE);

                $scope.RESOLVE_DUE_TIMER = {
                    DAYS: 0,
                    HOURS: 0,
                    MINUTES: 0,
                    SECONDS: 0,
                    GET_DUE_TIME_REMAINING: function(RESPOND_DUE) {
                        var TOTAL = Date.parse(RESPOND_DUE) - Date.parse(new Date());
                        var SECONDS = Math.floor((TOTAL / 1000) % 60);
                        var MINUTES = Math.floor((TOTAL / 1000 / 60) % 60);
                        var HOURS = Math.floor((TOTAL / (1000 * 60 * 60)) % 24);
                        var DAYS = Math.floor(TOTAL / (1000 * 60 * 60 * 24));
                        return {
                            'TOTAL': TOTAL,
                            'DAYS': DAYS,
                            'HOURS': HOURS,
                            'MINUTES': MINUTES,
                            'SECONDS': SECONDS
                        };
                    },

                    INITIALIZE_RESOLVE_DUE_CLOCK: function(RESPOND_DUE) {
                        function UPDATE_DUE_CLOCK() {
                            var TOTAL = $scope.RESOLVE_DUE_TIMER.GET_DUE_TIME_REMAINING(RESPOND_DUE);
                            $scope.RESOLVE_DUE_TIMER.DAYS = TOTAL.DAYS < 10 ? '0' + TOTAL.DAYS : TOTAL.DAYS;
                            $scope.RESOLVE_DUE_TIMER.HOURS = ('0' + TOTAL.HOURS).slice(-2);
                            $scope.RESOLVE_DUE_TIMER.MINUTES = ('0' + TOTAL.MINUTES).slice(-2);
                            $scope.RESOLVE_DUE_TIMER.SECONDS = ('0' + TOTAL.SECONDS).slice(-2);
                            if (TOTAL.TOTAL <= 0) {
                                $interval.cancel(DUE_TIME_INTERVAL);
                            }
                        }

                        UPDATE_DUE_CLOCK();
                        var DUE_TIME_INTERVAL = $interval(UPDATE_DUE_CLOCK, 1000);
                    }
                }
                $scope.RESOLVE_DUE_TIMER.INITIALIZE_RESOLVE_DUE_CLOCK(RESOLVE_DUE);
            }
            $rootScope.CHECK_FIELD_CONDITION = function(FIELD, PARENT) {
                $scope.PARENT_FIELD_S = $filter('filter')($scope.TICKET.CUSTOM_FIELDS, function(value) {
                    return value.ID === PARENT;
                });
                $scope.PARENT_FIELD = $scope.PARENT_FIELD_S[0]
                if (FIELD.ACTIVE) {
                    if (FIELD.CONDITION.STATUS) {
                        switch (FIELD.CONDITION.OPERATOR) {
                            case 1:
                                if (FIELD.CONDITION.VALUE.includes($scope.PARENT_FIELD.DATA) || FIELD.CONDITION.VALUE.includes($scope.PARENT_FIELD.SELECTED)) {
                                    return true;
                                } else {
                                    return false;
                                }
                            case 2:
                                if (!(FIELD.CONDITION.VALUE.includes($scope.PARENT_FIELD.DATA)) || !(FIELD.CONDITION.VALUE.includes($scope.PARENT_FIELD.SELECTED))) {
                                    return true;
                                } else {
                                    return false;
                                }
                            case 3:
                                if ($scope.PARENT_FIELD.DATA > FIELD.CONDITION.VALUE[0]) {
                                    return true;
                                } else {
                                    return false;
                                }
                            case 4:
                                if ($scope.PARENT_FIELD.DATA < FIELD.CONDITION.VALUE[0]) {
                                    return true;
                                } else {
                                    return false;
                                }
                        }
                    } else {
                        return true;
                    }
                } else {
                    return false;
                }
            };
        });
    }

    $scope.STR_LIMIT = 3;

    $scope.SHOW_MORE_LOGS = function() {
        $scope.STR_LIMIT += $scope.STR_LIMIT;
    };

    $scope.REMOVE_TICKET = function() {

        var dataObj = $.param({
            ID: $scope.TICKET.ID,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/REMOVE_TICKET', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $location.path('/tickets');
                    toastr.success($filter('translate')('TICKET_REMOVED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $rootScope.GET_TICKET_DETAIL();

    $scope.MESSAGE = {
        CONTENT: '',
    };

    $scope.ADD_MESSAGE = function() {
        var dataObj = $.param({
            RELATION_TYPE: 'TICKET',
            RELATED_ID: $scope.TICKET.ID,
            RECEIVER_ID: $scope.TICKET.USER.ID,
            MESSAGE: $scope.MESSAGE.CONTENT,
            ATTACHMENT: $scope.TMP_UPLOADS,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/ADD_MESSAGE', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.SHOW_REPLY_AREA = false;
                    $scope.MESSAGE.CONTENT = '';
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.NOTE_PERMISSION = false;

    $scope.ADD_NOTE = function() {
        var dataObj = $.param({
            RELATION_TYPE: 'TICKET',
            RELATED_ID: $scope.TICKET.ID,
            NOTE: $scope.NOTE,
            PRIVATE: $scope.NOTE_PERMISSION,
            ATTACHMENT: $scope.TMP_UPLOADS,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/ADD_NOTE', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.SHOW_NOTE_AREA = false;
                    $scope.NOTE_PERMISSION = false;
                    $scope.NOTE = null;
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.ASSIGN_STAFF = function(ASSIGNED_STAFF_ID) {
        var dataObj = $.param({
            TICKET_ID: $scope.TICKET.ID,
            TICKET_TOKEN: $scope.TICKET.TOKEN,
            ASSIGNED_STAFF_ID: ASSIGNED_STAFF_ID,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/ASSIGN_STAFF', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $http.get(APP_URL + "api/GET_CANNED_RESPONSES").then(function(GET_CANNED_RESPONSES) {
        $scope.CANNED_RESPONSES = GET_CANNED_RESPONSES.data;
        $scope.CREATE_CANNED_RESPONSE = function() {
            var dataObj = $.param({
                NAME: $scope.CANNED_NAME,
                MESSAGE: $scope.CANNED_MESSAGE,
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'api/CREATE_CANNED_RESPONSE', dataObj, config)
                .then(
                    function(RESPONSE) {
                        console.log(RESPONSE);
                        $scope.CANNED_RESPONSES.push(RESPONSE.data);
                    },
                    function(RESPONSE) {
                        console.log(RESPONSE);
                    }
                );
        }
    });

    $scope.ADD_PREDEFINED_MESSAGE_TO = function(REPLY) {
        $scope.MESSAGE.CONTENT = REPLY.MESSAGE;
        $scope.CANNED_RESPONSE.AREA = false;
        window.scrollTo(0, 300);
    };

    $scope.SHOW_REPLY_BOTTOM = function() {
        $scope.BOTTOM_REPLY_AREA = true;
    };

    $scope.CHANGE_TICKET_STATUS = function(STATUS) {
        var dataObj = $.param({
            TICKET_ID: $scope.TICKET.ID,
            CLIENT: $scope.TICKET.CLIENT,
            STATUS: STATUS,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/CHANGE_TICKET_STATUS', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.CHANGE_TICKET_PROCESS = function(PROCESS) {
        var dataObj = $.param({
            TICKET_ID: $scope.TICKET.ID,
            CLIENT: $scope.TICKET.CLIENT,
            PROCESS: PROCESS,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/CHANGE_TICKET_PROCESS', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.CHANGE_TICKET_PRIORITY = function(PRIORITY) {
        var dataObj = $.param({
            TICKET_ID: $scope.TICKET.ID,
            PRIORITY: PRIORITY,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/CHANGE_TICKET_PRIORITY', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.CHANGE_TICKET_DEPARTMENT = function(DEPARTMENT) {
        var dataObj = $.param({
            TICKET_ID: $scope.TICKET.ID,
            DEPARTMENT: DEPARTMENT,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/CHANGE_TICKET_DEPARTMENT', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.MARK_TICKET_AS_SPAM = function(DEPARTMENT) {
        var dataObj = $.param({
            TICKET_ID: $scope.TICKET.ID,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/MARK_TICKET_AS_SPAM', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('TICKET_MARKED_AS_SPAM_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.MARK_TICKET_AS_NOT_SPAM = function(DEPARTMENT) {
        var dataObj = $.param({
            TICKET_ID: $scope.TICKET.ID,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/MARK_TICKET_AS_NOT_SPAM', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('TICKET_MARKED_AS_NOT_SPAM_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.CHANGE_TICKET_SLA_POLICIY = function(SLA_POLICY) {
        var dataObj = $.param({
            TICKET_ID: $scope.TICKET.ID,
            SLA_POLICY: SLA_POLICY,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/CHANGE_TICKET_SLA_POLICIY', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.REMOVE_REPLY = function(ID) {
        var dataObj = $.param({
            ID: ID
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/REMOVE_REPLY', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.REMOVE_NOTE = function(ID) {
        var dataObj = $.param({
            ID: ID
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/REMOVE_NOTE', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.MERGE = {
        "SHOW": false,
        "MERGE_THREADS": false,
        "PARENT_STATUS": "1",
        "CHILD_STATUS": "4"
    }

    $scope.TICKETS_TO_MERGE = [];

    $http.get(APP_URL + "api/GET_TICKET_DETAIL/" + $routeParams.id).then(function(TICKET) {
        $scope.TICKETS_TO_MERGE.push(TICKET.data);
    });

    $scope.MERGE_SELECTED_TICKETS = function() {
        $scope.MERGE.SHOW = true;
        $scope.TICKETS_TO_MERGE = $scope.SELECTED;
    }

    $scope.SEARCH_TICKET_FOR_MERGE = function() {
        var dataObj = $.param({
            KEY: $scope.SEARCH_KEY
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/SEARCH_TICKET_FOR_MERGE', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $http.get(APP_URL + "api/GET_TICKET_DETAIL/" + RESPONSE.data.TOKEN).then(function(TICKET) {
                        $scope.TICKET_FOUND = TICKET.data;
                    });
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.ADD_TO_MERGE = function() {
        $scope.TICKETS_TO_MERGE.push(
            $scope.TICKET_FOUND
        );
        for (var i = 0; i < $scope.TICKETS_TO_MERGE.length; i++) {
            $scope.TICKETS_TO_MERGE[i].ID = i.toString();
        }
        $scope.SEARCH_KEY = null;
    };

    $scope.REMOVE_FROM_MERGE_LIST = function(index) {
        $scope.TICKETS_TO_MERGE.splice(index, 1);
        $scope.PARENT_TICKET_TOKEN = null;
    };

    $scope.SELECT_PARENT_TICKET = function(TOKEN) {
        $scope.PARENT_TICKET_TOKEN = TOKEN;
    }

    $scope.START_MERGING = function() {
        var dataObj = $.param({
            TICKETS: $scope.TICKETS_TO_MERGE,
            MERGE_THREADS: $scope.MERGE.MERGE_THREADS,
            PARENT_STATUS: $scope.MERGE.PARENT_STATUS,
            CHILD_STATUS: $scope.MERGE.CHILD_STATUS,
            PARENT_TICKET_TOKEN: $scope.PARENT_TICKET_TOKEN
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/START_MERGING';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('TICKETS_MERGED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                    $scope.MERGE = {
                        "SHOW": false,
                        "MERGE_THREADS": false,
                        "PARENT_STATUS": "1",
                        "CHILD_STATUS": "4"
                    }
                    $scope.PARENT_TICKET_TOKEN = null;
                    $scope.GET_TICKET_DETAIL();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

});

App.controller("Reports", function($scope, $rootScope, $http, $filter, PrivilegeService) {
    "use strict";

    PrivilegeService.CHECK('reports');

    $rootScope.PAGE_TITLE = $filter('translate')('Reports') + ' | ' + $rootScope.APPLICATION_NAME;
});

App.controller("Knowledge", function($scope, $rootScope, $http, $filter, PrivilegeService, $mdConstant, $routeParams, toastr, $location) {
    "use strict";

    PrivilegeService.CHECK('knowledge');

    $rootScope.PAGE_TITLE = $filter('translate')('Knowledge_Base') + ' | ' + $rootScope.APPLICATION_NAME;


    // Data fetch //
    $scope.FILTER = {
        KEYWORD: '',
        INDEX: 1,
        MAX_SIZE: 8,
        SELECTED_PAGE_SIZE: 8,
    };

    $scope.RESET_FILTER = function() {
        $scope.FILTER = {
            KEYWORD: '',
            INDEX: 1,
            MAX_SIZE: 8,
            SELECTED_PAGE_SIZE: 8,
        };
        $scope.GET_FILTERED_DATA();
    };

    $scope.TOTAL_COUNT = 0;

    $scope.GET_FILTERED_DATA = function() {
        $http({
            method: 'POST',
            url: APP_URL + "api/GET_ALL_ARTICLES",
            data: {
                LIMIT: $scope.FILTER.SELECTED_PAGE_SIZE,
                OFFSET: $scope.FILTER.INDEX,
                FILTER: {
                    KEYWORD: $scope.FILTER.KEYWORD,
                }
            },
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        }).then(function(response) {
            $scope.ARTICLES = response.data.ARTICLES;
            $scope.TOTAL_COUNT = response.data.TOTAL;
            $scope.ALL_TOTAL = response.data.ALL_TOTAL;
            $scope.PAGE_NUMBER = Math.ceil($scope.TOTAL_DATA / $scope.PAGE_SIZE);
        });
    };

    $scope.GET_FILTERED_DATA();

    $scope.PAGE_CHANGED = function(PAGE_INDEX) {
        $scope.GET_FILTERED_DATA(PAGE_INDEX);
    };
    $scope.CHANGE_PAGE_SIZE = function() {
        $scope.PAGE_INDEX = 1;
        $scope.GET_FILTERED_DATA();
    };
    // Data fetch //

    $http.get(APP_URL + "api/GET_ARTICLE_CATEGORIES/").then(function(ARTICLE_CATEGORIES) {
        $scope.ARTICLE_CATEGORIES = ARTICLE_CATEGORIES.data;
    });

    $scope.NEW_CATEGORY = function(index) {
        var dataObj = $.param({
            NAME: 'empty'
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/NEW_CATEGORY', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.ARTICLE_CATEGORIES.push(RESPONSE.data);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }


    $scope.REMOVE_CATEGORY = function(index) {
        var CATEGORY = $scope.ARTICLE_CATEGORIES[index];
        var dataObj = $.param({
            ID: CATEGORY.ID
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/REMOVE_CATEGORY', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.ARTICLE_CATEGORIES.splice($scope.ARTICLE_CATEGORIES.indexOf(CATEGORY), 1);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.RENAME_CATEGORY = function(ID, NAME) {
        var dataObj = $.param({
            ID: ID,
            NAME: NAME
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/RENAME_CATEGORY', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.TAG_KEYS = [$mdConstant.KEY_CODE.ENTER, $mdConstant.KEY_CODE.COMMA];
    //NEWS SECTION

    $scope.ADD_TAGS = function(RELATION, REL_ID, TAGS) {
        var dataObj = $.param({
            RELATION_TYPE: RELATION,
            ID: REL_ID,
            TAGS: JSON.stringify(TAGS)
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/ADD_TAGS', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.NEW_ARTICLE = {
        KEYWORDS: [],
        DESCRIPTION: '',
        TITLE: '',
        CONTENT: '',
        CATEGORY: 0
    }

    $scope.TOOGLE_OPTIONS_NEWS_CATEGORIES = function(item) {
        var idx = $scope.NEW_ARTICLE.CATEGORIES.indexOf(item);
        if (idx > -1) {
            $scope.NEW_ARTICLE.CATEGORIES.splice(idx, 1);
        } else {
            $scope.NEW_ARTICLE.CATEGORIES.push(item);
        }
    };
    $scope.EXIST_OPTIONS_NEWS_CATEGORIES = function(item) {
        return $scope.NEW_ARTICLE.CATEGORIES.indexOf(item) > -1;
    };


    $scope.ADD_NEW_ARTICLE = function() {
        var DATA_OBJ = $.param({
            DESCRIPTION: $scope.NEW_ARTICLE.DESCRIPTION,
            TITLE: $scope.NEW_ARTICLE.TITLE,
            CONTENT: $scope.NEW_ARTICLE.CONTENT,
            CATEGORY: $scope.NEW_ARTICLE.CATEGORY,
            KEYWORDS: JSON.stringify($scope.NEW_ARTICLE.KEYWORDS),
        });
        var CONFIG = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var POST_URL = APP_URL + "api/ADD_NEW_ARTICLE";
        $http.post(POST_URL, DATA_OBJ, CONFIG).then(
            function(RESPONSE) {
                console.log(RESPONSE);
                $scope.TYPE_NEWS = false;
                $scope.NEW_ARTICLE = {
                    KEYWORDS: [],
                    DESCRIPTION: '',
                    TITLE: '',
                    CONTENT: '',
                    CATEGORY: 0
                }
                toastr.success($filter('translate')('ARTICLE_ADDED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
            },
            function(RESPONSE) {
                console.log(RESPONSE);
            }
        );
    };

    if ($routeParams.id) {
        $http.get(APP_URL + "api/GET_ARTICLE/" + $routeParams.id).then(function(ARTICLE) {
            $scope.ARTICLE = ARTICLE.data;
            $scope.UPDATE_ARTICLE = function() {
                var DATA_OBJ = $.param({
                    ID: $scope.ARTICLE.ID,
                    DESCRIPTION: $scope.ARTICLE.DESCRIPTION,
                    TITLE: $scope.ARTICLE.TITLE,
                    SHOW: $scope.ARTICLE.SHOW,
                    CONTENT: $scope.ARTICLE.CONTENT,
                    CATEGORY: $scope.ARTICLE.CATEGORY,
                    KEYWORDS: JSON.stringify($scope.ARTICLE.KEYWORDS),
                });
                var CONFIG = {
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
                };
                var POST_URL = APP_URL + "api/UPDATE_ARTICLE";
                $http.post(POST_URL, DATA_OBJ, CONFIG).then(
                    function(RESPONSE) {
                        console.log(RESPONSE);
                        toastr.success($filter('translate')('ARTICLE_UPDATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                    },
                    function(RESPONSE) {
                        console.log(RESPONSE);
                    }
                );
            };

            $scope.REMOVE_ARTICLE = function() {
                var dataObj = $.param({
                    ID: $scope.ARTICLE.ID
                });
                var config = {
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
                };
                $http.post(APP_URL + 'api/REMOVE_ARTICLE', dataObj, config)
                    .then(
                        function(RESPONSE) {
                            $location.path('knowledge-base');
                            toastr.warning($filter('translate')('ARTICLE_REMOVED_NOTIFICATION_TEXT'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                        },
                        function(RESPONSE) {
                            console.log(RESPONSE);
                        }
                    );
            };
        });
    }
});

App.controller("Options", function($scope, toastr, $http, $q, $window, $filter, $rootScope, PrivilegeService, FieldService, $mdDialog) {
    "use strict";

    PrivilegeService.CHECK('options');

    FieldService.GET('TICKETS', function(response) {
        $scope.CUSTOM_FIELDS = response;

    });
    $rootScope.PAGE_TITLE = $filter('translate')('Options') + ' | ' + $rootScope.APPLICATION_NAME;
    $http.get(APP_URL + "api/GET_LOCALES").then(function(LOCALES) {
        $rootScope.LOCALES = LOCALES.data;
        $scope.TIME_ZONES = $filter('filter')(LOCALES.data, function(value) {
            return value.ID === $scope.OPTIONS.DEFAULT_LOCALE;
        });
    });

    $scope.CHANGE_DEFAULT_LOCALE = function() {
        $scope.TIME_ZONES = $filter('filter')($scope.LOCALES, function(value) {
            return value.ID === $scope.OPTIONS.DEFAULT_LOCALE;
        });
    };

    $http.get(APP_URL + "api/GET_EMAIL_OPTIONS").then(function(EMAIL_OPTIONS) {
        $scope.EMAIL_OPTIONS = EMAIL_OPTIONS.data;
    });

    $scope.UPDATE_OPTIONS = function() {
        var dataObj = $.param({
            NAME: $scope.OPTIONS.NAME,
            HELPDESK_STATUS: $scope.OPTIONS.HELPDESK_STATUS,
            VACATION_MODE: $scope.OPTIONS.VACATION_MODE,
            DEFAULT_DEPARTMENT: $scope.OPTIONS.DEFAULT_DEPARTMENT,
            APPLICATION_NAME: $scope.OPTIONS.APPLICATION_NAME,
            APP_COLOR: $scope.OPTIONS.APP_COLOR,
            LANG: $scope.OPTIONS.LANG,
            DESK_URL: $scope.OPTIONS.DESK_URL,
            MAX_PAGE_SIZE: $scope.OPTIONS.MAX_PAGE_SIZE,
            DEFAULT_LOCALE: $scope.OPTIONS.DEFAULT_LOCALE,
            DEFAULT_TIME_ZONE: $scope.OPTIONS.DEFAULT_TIME_ZONE,
            BUSINESS_HOURS: JSON.stringify($scope.OPTIONS.BUSINESS_HOURS),

        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/UPDATE_OPTIONS';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('OPTIONS_UPDATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.UPDATE_EMAIL_OPTIONS = function() {
        var dataObj = $.param({
            EMAIL_ENCRYPTION: $scope.EMAIL_OPTIONS.EMAIL_ENCRYPTION,
            SMTP_HOST: $scope.EMAIL_OPTIONS.SMTP_HOST,
            SMTP_PORT: $scope.EMAIL_OPTIONS.SMTP_PORT,
            SMTP_USER: $scope.EMAIL_OPTIONS.SMTP_USER,
            SMTP_PASS: $scope.EMAIL_OPTIONS.SMTP_PASS,
            NO_REPLY_EMAIL: $scope.EMAIL_OPTIONS.NO_REPLY_EMAIL,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/UPDATE_EMAIL_OPTIONS';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('EMAIL_OPTIONS_UPDATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.CHANGE_APP_LOGO = function() {
        document.getElementById("ATTACHMENT_LOGO").click();
    };
    $scope.CHANGE_APP_ICON = function() {
        document.getElementById("ATTACHMENT_ICON").click();
    };

    $scope.UPLOAD_APP_LOGO = function() {
        $scope.FILE_IS_UPLOADING = true;
        var fd = new FormData();
        var files = document.getElementById("ATTACHMENT_LOGO").files[0];
        fd.append("file", files);
        $http({
            method: "post",
            url: APP_URL + "api/UPLOAD_APP_LOGO",
            data: fd,
            uploadEventHandlers: {
                progress: function(e) {
                    if (e.lengthComputable) {
                        $scope.progressBar = (e.loaded / e.total) * 100;
                        $scope.progressCounter = $scope.progressBar.toFixed(2);
                        console.log($scope.progressCounter);
                    }
                }
            },
            headers: {
                "Content-Type": undefined
            },
        }).then(function successCallback(UPLOADED_ATTACHMENT) {
            $scope.UPLOADED_ATTACHMENT = UPLOADED_ATTACHMENT.data;
            $scope.TMP_UPLOADS.push($scope.UPLOADED_ATTACHMENT);
            $scope.FILE_IS_UPLOADING = false;
            $("input[type=file]").val('');
            $window.location.reload();
        });
    };

    $scope.UPLOAD_APP_ICON = function() {
        $scope.FILE_IS_UPLOADING = true;
        var fd = new FormData();
        var files = document.getElementById("ATTACHMENT_ICON").files[0];
        fd.append("file", files);
        $http({
            method: "post",
            url: APP_URL + "api/UPLOAD_APP_ICON",
            data: fd,
            uploadEventHandlers: {
                progress: function(e) {
                    if (e.lengthComputable) {
                        $scope.progressBar = (e.loaded / e.total) * 100;
                        $scope.progressCounter = $scope.progressBar.toFixed(2);
                        console.log($scope.progressCounter);
                    }
                }
            },
            headers: {
                "Content-Type": undefined
            },
        }).then(function successCallback(UPLOADED_ATTACHMENT) {
            $scope.UPLOADED_ATTACHMENT = UPLOADED_ATTACHMENT.data;
            $scope.TMP_UPLOADS.push($scope.UPLOADED_ATTACHMENT);
            $scope.FILE_IS_UPLOADING = false;
            $("input[type=file]").val('');
            $window.location.reload();
        });
    };


    // CUSTOM FIELDS //


    $scope.CUSTOM_FIELD_TYPES = [{
            ID: "1",
            TYPE: "input",
            NAME: "Input"
        },
        {
            ID: "2",
            TYPE: "date",
            NAME: "Date"
        },
        {
            ID: "3",
            TYPE: "textarea",
            NAME: "Text Area"
        },
        {
            ID: "4",
            TYPE: "select",
            NAME: "Select"
        },
        {
            ID: "5",
            TYPE: "radio",
            NAME: "Radio"
        },
        {
            ID: "6",
            TYPE: "upload",
            NAME: "Upload"
        },
        {
            ID: "7",
            TYPE: "checkbox",
            NAME: "Checkbox"
        }, {
            ID: "8",
            TYPE: "number",
            NAME: "Number"
        }
    ];

    $scope.SELECT_OPTIONS = [];

    $scope.ADD_OPTION = function() {
        $scope.SELECT_OPTIONS.push({
            NAME: $scope.NEW_FIELD.NEW_OPTION_NAME
        });
        for (var i = 0; i < $scope.SELECT_OPTIONS.length; i++) {
            $scope.SELECT_OPTIONS[i].ID = i.toString();
        }
        $scope.NEW_FIELD.NEW_OPTION_NAME = null;
    };

    $scope.REMOVE_OPTION = function(index) {
        $scope.SELECT_OPTIONS.splice(index, 1);
    };

    $scope.NEW_FIELD = {
        CONDITION: {
            STATUS: false,
            VALUE: [],
        }
    }

    $scope.ADD_NEW_CONDITION_VALUE = function() {
        $scope.NEW_FIELD.CONDITION.VALUE.push(
            $scope.NEW_FIELD.NEW_CONDITION_VALUE
        );
        $scope.NEW_FIELD.NEW_CONDITION_VALUE = null;
    };

    $scope.REMOVE_NEW_CONDITION_VALUE = function(index) {
        $scope.NEW_FIELD.CONDITION.VALUE.splice(index, 1);
    };


    $scope.ADD_FIELD = function() {
        if (
            $scope.NEW_FIELD.TYPE === "select" ||
            $scope.NEW_FIELD.TYPE === "radio" ||
            $scope.NEW_FIELD.TYPE === "checkbox"
        ) {
            $scope.DATA = JSON.stringify($scope.SELECT_OPTIONS);
        } else {
            $scope.DATA = null;
        }
        if ($scope.NEW_FIELD.CONDITION.STATUS) {
            $scope.CONDITION = JSON.stringify($scope.NEW_FIELD.CONDITION);
        } else {
            $scope.CONDITION = 'false';
        }
        var dataObj = $.param({
            NAME: $scope.NEW_FIELD.NAME,
            DESCRIPTION: $scope.NEW_FIELD.DESCRIPTION,
            TYPE: $scope.NEW_FIELD.TYPE,
            ORDER: $scope.NEW_FIELD.ORDER,
            DATA: $scope.DATA,
            RELATION_TYPE: 'TICKET',
            CONDITION: JSON.stringify($scope.NEW_FIELD.CONDITION),
            REQUIRED: $scope.NEW_FIELD.REQUIRED,
            PERMISSIONS: $scope.NEW_FIELD.PERMISSIONS,
            ACTIVE: $scope.NEW_FIELD.ACTIVE
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + "api/ADD_CUSTOM_FIELD";
        $http.post(posturl, dataObj, config).then(
            function(response) {
                console.log(response);
                $scope.NEW_FIELD = [];
                $scope.NEW_FIELD = {
                    CONDITION: {
                        STATUS: false,
                        VALUE: [],
                    }
                }
                $scope.SELECT_OPTIONS = [];
                $scope.CUSTOM_FIELDS.push(response.data);
                $scope.CREATE_CUSTOM_FIELD = false;
                toastr.success($filter('translate')('CUSTOM_FIELD_CREATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
            },
            function(response) {
                console.log(response);
            }
        );
    };

    $scope.GET_FIELD_DETAIL = function(index) {
        $scope.SELECTED_FIELD = $scope.CUSTOM_FIELDS[index];
        var FIELD_ID = $scope.SELECTED_FIELD.ID;
        $scope.ADD_OPTION_TO_FIELD = function() {
            $scope.SELECTED_FIELD.DATA.push({
                NAME: $scope.SELECTED_FIELD.NEW_OPTION_NAME
            });
            for (var i = 0; i < $scope.SELECTED_FIELD.DATA.length; i++) {
                $scope.SELECTED_FIELD.DATA[i].ID = i;
            }
            $scope.SELECTED_FIELD.NEW_OPTION_NAME = null;
        };
        $scope.ADD_CONDITION_TO_FIELD = function() {
            $scope.SELECTED_FIELD.CONDITION.VALUE.push($scope.SELECTED_FIELD.NEW_CONDITION_VALUE);
            for (var i = 0; i < $scope.SELECTED_FIELD.CONDITION.VALUE.length; i++) {
                $scope.SELECTED_FIELD.CONDITION.VALUE[i].ID = i;
            }
            $scope.SELECTED_FIELD.NEW_CONDITION_VALUE = null;
        };
        $scope.REMOVE_CONDITION_FROM_FIELD = function(index) {
            $scope.SELECTED_FIELD.CONDITION.VALUE.splice(index, 1);
        };
        $scope.REMOVE_OPTION_FROM_FIELD = function(index) {
            $scope.SELECTED_FIELD.DATA.splice(index, 1);
        };
        $scope.UPDATE_FIELD = function() {
            if (
                $scope.SELECTED_FIELD.TYPE === "select" ||
                $scope.SELECTED_FIELD.TYPE === "radio" ||
                $scope.SELECTED_FIELD.TYPE === "checkbox"
            ) {
                $scope.DATA = JSON.stringify($scope.SELECTED_FIELD.DATA);
            } else {
                $scope.DATA = null;
            }
            if ($scope.SELECTED_FIELD.CONDITION.STATUS) {
                $scope.CONDITION = JSON.stringify($scope.SELECTED_FIELD.CONDITION);
            } else {
                $scope.CONDITION = 'false';
            }
            var dataObj = $.param({
                NAME: $scope.SELECTED_FIELD.NAME,
                DESCRIPTION: $scope.SELECTED_FIELD.DESCRIPTION,
                TYPE: $scope.SELECTED_FIELD.TYPE,
                ORDER: $scope.SELECTED_FIELD.ORDER,
                DATA: $scope.DATA,
                RELATION_TYPE: 'TICKET',
                CONDITION: JSON.stringify($scope.SELECTED_FIELD.CONDITION),
                REQUIRED: $scope.SELECTED_FIELD.REQUIRED,
                PERMISSIONS: $scope.SELECTED_FIELD.PERMISSIONS,
                ACTIVE: $scope.SELECTED_FIELD.ACTIVE
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            var posturl = APP_URL + "api/UPDATE_CUSTOM_FIELD/" + FIELD_ID;
            $http.post(posturl, dataObj, config).then(
                function(response) {
                    console.log(response);
                    toastr.success($filter('translate')('CUSTOM_FIELD_UPDATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                },
                function(response) {
                    console.log(response);
                }
            );
        };
    };

    $scope.REMOVE_FIELD = function() {
        var confirm = $mdDialog
            .confirm()
            .title("Remove custom field")
            .textContent("Are you sure?")
            .ariaLabel("Remove Field")
            .targetEvent($scope.SELECTED_FIELD)
            .ok("Remove")
            .cancel("Cancel!");

        $mdDialog.show(confirm).then(
            function() {
                var config = {
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
                };
                $http
                    .post(APP_URL + "api/REMOVE_CUSTOM_FIELD/" + $scope.SELECTED_FIELD.ID, config)
                    .then(
                        function(response) {
                            console.log(response);
                            toastr.success($filter('translate')('CUSTOM_FIELD_REMOVED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                            $scope.CUSTOM_FIELDS.splice($scope.SELECTED_FIELD, 1);
                        },
                        function(response) {
                            console.log(response);
                        }
                    );
            },
            function() {
                //
            }
        );
    };

    // CUSTOM FIELDS //

    $scope.NEW_DEPARTMENT = function(index) {
        var dataObj = $.param({
            NAME: 'empty'
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/NEW_DEPARTMENT', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.DEPARTMENTS.push(RESPONSE.data);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }


    $scope.REMOVE_DEPARTMENT = function(index) {
        var DEPARTMENT = $scope.DEPARTMENTS[index];
        var dataObj = $.param({
            ID: DEPARTMENT.ID
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/REMOVE_DEPARTMENT', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $scope.DEPARTMENTS.splice($scope.DEPARTMENTS.indexOf(DEPARTMENT), 1);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.RENAME_DEPARTMENT = function(ID, NAME) {
        var dataObj = $.param({
            ID: ID,
            NAME: NAME
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/RENAME_DEPARTMENT', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    // PROCESSES

    $scope.NEW_PROCESSES = function(DEPARTMENT_ID) {
        var dataObj = $.param({
            NAME: 'empty',
            DEPARTMENT_ID: DEPARTMENT_ID
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/NEW_PROCESSES', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $window.location.reload();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.REMOVE_PROCESSES = function(ID) {
        var dataObj = $.param({
            ID: ID
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/REMOVE_PROCESSES', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $window.location.reload();
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.RENAME_PROCESSES = function(ID, NAME) {
        var dataObj = $.param({
            ID: ID,
            NAME: NAME
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/RENAME_PROCESSES', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }
});

App.controller("Sla", function($scope, toastr, $http, $q, $timeout, $filter, $rootScope, PrivilegeService, $routeParams) {
    "use strict";

    PrivilegeService.CHECK('sla');

    $rootScope.PAGE_TITLE = $filter('translate')('SLA') + ' | ' + $rootScope.APPLICATION_NAME;

    $http.get(APP_URL + "api/GET_ALL_CLIENTS/" + $routeParams.id).then(function(ALL_CLIENTS) {
        $scope.ALL_CLIENTS = ALL_CLIENTS.data;
    });

    $http.get(APP_URL + "api/GET_SLA_POLICIES").then(function(SLA_POLICIES) {
        $scope.SLA_POLICIES = SLA_POLICIES.data;
    });

    $http.get(APP_URL + "api/GET_ALL_STAFF").then(function(ALL_STAFF) {
        $scope.ALL_STAFF = ALL_STAFF.data;
    });

    $scope.SLA_PERIODS = [{
            ID: "1",
            NAME: $filter('translate')('Mins')
        },
        {
            ID: "2",
            NAME: $filter('translate')('Hrs')
        }, {
            ID: "3",
            NAME: $filter('translate')('Days')
        },
        {
            ID: "4",
            NAME: $filter('translate')('Mos')
        },
    ];

    $scope.OPERATIONAL_HOURSES = [{
            ID: "1",
            NAME: $filter('translate')('Business')
        },
        {
            ID: "2",
            NAME: $filter('translate')('Calendar')
        },
    ];

    $scope.SLA_POLICY_TRIGGERS = [{
            ID: "1",
            NAME: "Client",
        },
        {
            ID: "2",
            NAME: "User",
        },
    ];

    $scope.SLA_POLICY = {
        NAME: '',
        DESCRIPTION: '',
        TRIGGER: {
            RELATION_TYPE: 0,
            RELATION: 0,
        },
        VIOLATION_RULES: [{
            ID: 1,
            NAME: $filter('translate')('SLA_VIO_RESPOND_TITLE'),
            DESCRIPTION: $filter('translate')('SLA_VIO_RESPOND_DESC'),
            ESCALATE: 0,
            WARN_ASSIGNED: true,
            INFORM: []
        }, {
            ID: 2,
            NAME: $filter('translate')('SLA_VIO_RESOLVE_TITLE'),
            DESCRIPTION: $filter('translate')('SLA_VIO_RESOLVE_DESC'),
            ESCALATE: 0,
            WARN_ASSIGNED: true,
            INFORM: []
        }],
        TARGETS: [{
            ID: 1,
            NAME: $filter('translate')('PRIORITY_LOW'),
            OPERATIONAL_HOURSES: 1,
            DATA: [{
                    NAME: $filter('translate')('RESPOND'),
                    TIME: 10,
                    PERIOD: 1,
                },
                {
                    NAME: $filter('translate')('RESOLVE'),
                    TIME: 10,
                    PERIOD: 1,
                }
            ]
        }, {
            ID: 2,
            NAME: $filter('translate')('PRIORITY_MEDIUM'),
            OPERATIONAL_HOURSES: 1,
            DATA: [{
                    NAME: $filter('translate')('RESPOND'),
                    TIME: 10,
                    PERIOD: 1,
                },
                {
                    NAME: $filter('translate')('RESOLVE'),
                    TIME: 10,
                    PERIOD: 1,
                },
            ]
        }, {
            ID: 3,
            NAME: $filter('translate')('PRIORITY_HIGH'),
            OPERATIONAL_HOURSES: 1,
            DATA: [{
                    NAME: $filter('translate')('RESPOND'),
                    TIME: 10,
                    PERIOD: 1,
                },
                {
                    NAME: $filter('translate')('RESOLVE'),
                    TIME: 10,
                    PERIOD: 1,
                }
            ]
        }],
        ACTIVE: true
    };

    $scope.asyncContacts = [];

    $scope.GET_STAFF = (function(search) {
        var deferred = $q.defer();
        $timeout(function() {
            deferred.resolve($scope.ALL_STAFF);
        }, Math.random() * 500, false);
        return deferred.promise;
    });

    $scope.TRIGGER = false;
    $scope.CREATE_SLA = function() {
        var dataObj = $.param({
            NAME: $scope.SLA_POLICY.NAME,
            DESCRIPTION: $scope.SLA_POLICY.DESCRIPTION,
            TRIGGER: JSON.stringify($scope.SLA_POLICY.TRIGGER),
            VIOLATION_RULES: JSON.stringify($scope.SLA_POLICY.VIOLATION_RULES),
            TARGETS: JSON.stringify($scope.SLA_POLICY.TARGETS),
            ACTIVE: $scope.SLA_POLICY.ACTIVE,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/ADD_SLA', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    if (RESPONSE.data) {
                        toastr.success($filter('translate')('SLA_CREATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                    } else {
                        toastr.warning($filter('translate')('SLA_NOT_CREATED_NOTIFICATION_TEXT'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                    }
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }
});

App.controller("Staff", function($scope, toastr, $http, $routeParams, $rootScope, $filter, PrivilegeService, $window, $location) {
    "use strict";

    PrivilegeService.CHECK('staff');

    $rootScope.PAGE_TITLE = $filter('translate')('Staff') + ' | ' + $rootScope.APPLICATION_NAME;

    $http.get(APP_URL + "api/GET_ALL_STAFF").then(function(ALL_STAFF) {
        $scope.ALL_STAFF = ALL_STAFF.data;
    });

    if ($routeParams.id) {
        $http.get(APP_URL + "api/GET_STAFF/" + $routeParams.id).then(function(STAFF) {
            $scope.STAFF = STAFF.data;
        });
    }

    $scope.NEW_USER = {
        STAFF: false,
        ADMIN: false,
        PRIVILEGES: [{
                "ID": "1",
                "NAME": $filter('translate')('Clients'),
                "VALUE": true
            },
            {
                "ID": "2",
                "NAME": $filter('translate')('Tickets'),
                "VALUE": true
            },
            {
                "ID": "3",
                "NAME": $filter('translate')('Reports'),
                "VALUE": false
            },
            {
                "ID": "4",
                "NAME": $filter('translate')('Options'),
                "VALUE": false
            },
            {
                "ID": "5",
                "NAME": $filter('translate')('Staff'),
                "VALUE": false
            },
            {
                "ID": "6",
                "NAME": $filter('translate')('SLA'),
                "VALUE": false
            },
            {
                "ID": "6",
                "NAME": $filter('translate')('Knowledge_Base'),
                "VALUE": false
            }
        ]
    }

    $scope.CREATE_STAFF = function(HAS_CLIENT) {
        var dataObj = $.param({
            NAME: $scope.NEW_USER.NAME,
            SURNAME: $scope.NEW_USER.SURNAME,
            PHONE: $scope.NEW_USER.PHONE,
            ADDRESS: $scope.NEW_USER.ADDRESS,
            LANGUAGE: $scope.NEW_USER.LANGUAGE,
            DEPARTMENT_ID: $scope.NEW_USER.DEPARTMENT_ID,
            EMAIL: $scope.NEW_USER.EMAIL,
            WORKING_HOURS: JSON.stringify($scope.OPTIONS.BUSINESS_HOURS),
            PRIVILEGES: JSON.stringify($scope.NEW_USER.PRIVILEGES),
            STAFF: $scope.NEW_USER.STAFF,
            SHOW: $scope.NEW_USER.SHOW,
            PASSWORD: $scope.NEW_USER.PASSWORD,
            ADMIN: $scope.NEW_USER.ADMIN,
            PARENT_CLIENT: HAS_CLIENT,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/CREATE_STAFF', dataObj, config)
            .then(
                function(RESPONSE) {
                    $window.location.reload();
                    toastr.success($filter('translate')('STAFF_CREATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                    $scope.NEW_USER = [];
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.UPDATE_STAFF = function() {
        var dataObj = $.param({
            ID: $scope.STAFF.ID,
            NAME: $scope.STAFF.NAME,
            SURNAME: $scope.STAFF.SURNAME,
            PHONE: $scope.STAFF.PHONE,
            DEPARTMENT_ID: $scope.STAFF.DEPARTMENT_ID,
            LANGUAGE: $scope.STAFF.LANGUAGE,
            ADDRESS: $scope.STAFF.ADDRESS,
            EMAIL: $scope.STAFF.EMAIL,
            WORKING_HOURS: JSON.stringify($scope.STAFF.WORKING_HOURS),
            STAFF: $scope.STAFF.STAFF,
            PASSWORD: $scope.STAFF.PASSWORD,
            ADMIN: $scope.STAFF.ADMIN,
            ACTIVE: $scope.STAFF.ACTIVE,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/UPDATE_STAFF';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('STAFF_UPDATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };

    $scope.REMOVE_USER = function() {
        var dataObj = $.param({
            ID: $scope.STAFF.ID,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        $http.post(APP_URL + 'api/REMOVE_STAFF', dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    $location.path('/staff');
                    toastr.warning($filter('translate')('STAFF_REMOVED_NOTIFICATION_TEXT'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    }

    $scope.UPDATE_PRIVILAGE = function(USER_ID, VALUE, PERMISSION_ID) {
        $http.post(
                APP_URL + "api/UPDATE_PRIVILEGE/" + USER_ID + "/" + VALUE + "/" + PERMISSION_ID)
            .then(
                function(response) {
                    console.log(response);
                },
                function(response) {
                    console.log(response);
                    toastr.warning($filter('translate')('DONT_HAVE_PERMISSION'), $filter('translate')('WARNING_NOTIFICATION_TEXT'));
                }
            );
    };

});

App.controller("Profile", function($scope, toastr, $http, $routeParams, $rootScope, $filter, PrivilegeService, $window, $location) {
    "use strict";

    $http.get(APP_URL + "api/GET_STAFF_LOGGED_IN/" + $routeParams.id).then(function(STAFF) {
        $scope.STAFF = STAFF.data;
        $rootScope.PAGE_TITLE = $scope.STAFF.NAME + ' ' + $scope.STAFF.SURNAME + ' | ' + $rootScope.APPLICATION_NAME;
    });

    $scope.UPDATE_PROFILE = function() {
        var dataObj = $.param({
            ID: $scope.STAFF.ID,
            NAME: $scope.STAFF.NAME,
            SURNAME: $scope.STAFF.SURNAME,
            PHONE: $scope.STAFF.PHONE,
            LANGUAGE: $scope.STAFF.LANGUAGE,
            ADDRESS: $scope.STAFF.ADDRESS,
            EMAIL: $scope.STAFF.EMAIL,
            WORKING_HOURS: JSON.stringify($scope.STAFF.WORKING_HOURS),
            PASSWORD: $scope.STAFF.PASSWORD,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/UPDATE_PROFILE';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('STAFF_UPDATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };
});

App.controller("Policy", function($scope, $http, toastr, $q, $timeout, $routeParams, PrivilegeService, $filter) {
    "use strict";

    PrivilegeService.CHECK('sla');

    $http.get(APP_URL + "api/GET_ALL_CLIENTS/" + $routeParams.id).then(function(ALL_CLIENTS) {
        $scope.ALL_CLIENTS = ALL_CLIENTS.data;
    });

    $http.get(APP_URL + "api/GET_ALL_STAFF").then(function(ALL_STAFF) {
        $scope.ALL_STAFF = ALL_STAFF.data;
    });

    $scope.asyncContacts = [];

    $scope.GET_STAFF = (function(search) {
        var deferred = $q.defer();
        $timeout(function() {
            deferred.resolve($scope.ALL_STAFF);
        }, Math.random() * 500, false);
        return deferred.promise;
    });

    $scope.SLA_PERIODS = [{
            ID: "1",
            NAME: $filter('translate')('Mins')
        },
        {
            ID: "2",
            NAME: $filter('translate')('Hrs')
        }, {
            ID: "3",
            NAME: $filter('translate')('Days')
        },
        {
            ID: "4",
            NAME: $filter('translate')('Mos')
        },
    ];

    $scope.OPERATIONAL_HOURSES = [{
            ID: "1",
            NAME: $filter('translate')('Business')
        },
        {
            ID: "2",
            NAME: $filter('translate')('Calendar')
        },
    ];

    $scope.SLA_POLICY_TRIGGERS = [{
            ID: "1",
            NAME: "Client",
        },
        {
            ID: "2",
            NAME: "User",
        },
    ];
    $http.get(APP_URL + "api/GET_POLICY/" + $routeParams.id).then(function(POLICY) {
        $scope.POLICY = POLICY.data;
    });

    $scope.UPDATE_POLICY = function() {
        var dataObj = $.param({
            ID: $scope.POLICY.ID,
            NAME: $scope.POLICY.NAME,
            DESCRIPTION: $scope.POLICY.DESCRIPTION,
            TRIGGER: JSON.stringify($scope.POLICY.TRIGGER),
            VIOLATION_RULES: JSON.stringify($scope.POLICY.VIOLATION_RULES),
            TARGETS: JSON.stringify($scope.POLICY.TARGETS),
            ACTIVE: $scope.POLICY.ACTIVE,
        });
        var config = {
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
        };
        var posturl = APP_URL + 'api/UPDATE_POLICY';
        $http.post(posturl, dataObj, config)
            .then(
                function(RESPONSE) {
                    console.log(RESPONSE);
                    toastr.success($filter('translate')('SLA_UPDATED_NOTIFICATION_TEXT'), $filter('translate')('SUCCESS_NOTIFICATION_TEXT'));
                },
                function(RESPONSE) {
                    console.log(RESPONSE);
                }
            );
    };


});

App.controller("Chart", function($scope, $http) {
    'use strict';

    $http.get(APP_URL + "api/GET_SOLVED_UNSOLVED_GRAHP").then(function(RESPONSE) {
        $scope.SOLVED_UNSOLVED_GRAHP = RESPONSE.data;
    });

    $http.get(APP_URL + "api/ASSIGNATED_STAFF_BASED_SOLIDARITY_APPLICATIONS_GRAHP").then(function(RESPONSE) {
        $scope.ASIGNATED_STAFF_BASED_DATA = RESPONSE.data;
    });

});

App.filter('trust', ['$sce', function($sce) {
    return function(value, type) {
        return $sce.trustAs(type || 'html', value);
    }
}])

App.filter('Filesize', function() {
    return function(size) {
        if (isNaN(size))
            size = 0;

        if (size < 1024)
            return size + ' Bytes';

        size /= 1024;

        if (size < 1024)
            return size.toFixed(2) + ' Kb';

        size /= 1024;

        if (size < 1024)
            return size.toFixed(2) + ' Mb';

        size /= 1024;

        if (size < 1024)
            return size.toFixed(2) + ' Gb';

        size /= 1024;

        return size.toFixed(2) + ' Tb';
    };
});

App.filter("cut", function() {
    return function(value, wordwise, max, tail) {
        if (!value) return "";
        max = parseInt(max, 10);
        if (!max) return value;
        if (value.length <= max) return value;
        value = value.substr(0, max);
        if (wordwise) {
            var lastspace = value.lastIndexOf(" ");
            if (lastspace !== -1) {
                if (
                    value.charAt(lastspace - 1) === "." ||
                    value.charAt(lastspace - 1) === ","
                ) {
                    lastspace = lastspace - 1;
                }
                value = value.substr(0, lastspace);
            }
        }
        return value + (tail || " …");
    };
});

App.filter('range', function() {
    return function(input, total) {
        total = parseInt(total);
        for (var i = 0; i < total; i++)
            input.push(i);
        return input;
    }
});

App.factory('AuthenticationService', ['Base64', '$http', '$cookieStore', '$rootScope', '$timeout', 'toastr', '$filter',
    function(Base64, $http, $cookieStore, $rootScope, $timeout, toastr, $filter) {
        var service = {};
        service.Login = function(USERNAME, PASSWORD, callback) {
            var dataObj = $.param({
                USERNAME: USERNAME,
                PASSWORD: PASSWORD,
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'auth/AUTHENTICATE', dataObj, config)
                .then(
                    function(RESPONSE) {
                        callback(RESPONSE);
                    },
                    function(RESPONSE) {
                        console.log(RESPONSE);
                        if (RESPONSE.data.REASON) {
                            toastr.error($filter('translate')('ACCOUNT_SUSPENDED'), $filter('translate')('ACCOUNT_SUSPENDED_TITLE'));
                        }
                    }
                );
        };
        service.SetCredentials = function(USERNAME, PASSWORD) {
            var AUTH_DATA = Base64.encode(USERNAME + ':' + PASSWORD);
            $rootScope.LOGGED_IN = {
                CURRENT_USER: {
                    USERNAME: USERNAME,
                    AUTH_DATA: AUTH_DATA
                }
            };
            $http.defaults.headers.common['Authorization'] = 'Basic ' + AUTH_DATA; // jshint ignore:line
            $cookieStore.put('LOGGED_IN', $rootScope.LOGGED_IN);
        };
        service.ClearCredentials = function() {
            $rootScope.LOGGED_IN = {};
            $cookieStore.remove('LOGGED_IN');
            $http.defaults.headers.common.Authorization = 'Basic ';
        };
        return service;
    }
])

App.factory('PrivilegeService', ['Base64', '$http', 'toastr', '$filter', '$location',
    function(Base64, $http, toastr, $filter, $location) {
        var service = {};
        service.CHECK = function(PATH, callback) {
            var dataObj = $.param({
                PATH: PATH,
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'auth/CHECK_PRIVILEGE', dataObj, config)
                .then(
                    function(RESPONSE) {

                    },
                    function(RESPONSE) {
                        $location.path('/dashboard');
                        toastr.error($filter('translate')('DONT_HAVE_PERMISSION'), $filter('translate')('ERROR_NOTIFICATION_TEXT'));
                    }
                );
        };
        return service;
    }
])

App.factory('OptionsService', function($http) {
    $http.get(APP_URL + "auth/GET_OPTIONS").then(function(OPTIONS) {
        return OPTIONS.data;
    });
});

App.factory('FieldService', ['Base64', '$http',
    function(Base64, $http) {
        var service = {};
        service.GET = function(RELATION_TYPE, callback) {
            var dataObj = $.param({
                RELATION_TYPE: RELATION_TYPE,
            });
            var config = {
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-API-KEY': 'PASSWORD' }
            };
            $http.post(APP_URL + 'api/GET_CUSTOM_FIELDS', dataObj, config)
                .then(
                    function(RESPONSE) {
                        callback(RESPONSE.data);
                    },
                    function(RESPONSE) {}
                );
        };
        return service;
    }
])

App.factory('Base64', function() {
    /* jshint ignore:start */

    var keyStr = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';

    return {
        encode: function(input) {
            var output = "";
            var chr1, chr2, chr3 = "";
            var enc1, enc2, enc3, enc4 = "";
            var i = 0;

            do {
                chr1 = input.charCodeAt(i++);
                chr2 = input.charCodeAt(i++);
                chr3 = input.charCodeAt(i++);

                enc1 = chr1 >> 2;
                enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
                enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
                enc4 = chr3 & 63;

                if (isNaN(chr2)) {
                    enc3 = enc4 = 64;
                } else if (isNaN(chr3)) {
                    enc4 = 64;
                }

                output = output +
                    keyStr.charAt(enc1) +
                    keyStr.charAt(enc2) +
                    keyStr.charAt(enc3) +
                    keyStr.charAt(enc4);
                chr1 = chr2 = chr3 = "";
                enc1 = enc2 = enc3 = enc4 = "";
            } while (i < input.length);

            return output;
        },

        decode: function(input) {
            var output = "";
            var chr1, chr2, chr3 = "";
            var enc1, enc2, enc3, enc4 = "";
            var i = 0;
            var base64test = /[^A-Za-z0-9\+\/\=]/g;
            if (base64test.exec(input)) {
                window.alert("There were invalid base64 characters in the input text.\n" +
                    "Valid base64 characters are A-Z, a-z, 0-9, '+', '/',and '='\n" +
                    "Expect errors in decoding.");
            }
            input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

            do {
                enc1 = keyStr.indexOf(input.charAt(i++));
                enc2 = keyStr.indexOf(input.charAt(i++));
                enc3 = keyStr.indexOf(input.charAt(i++));
                enc4 = keyStr.indexOf(input.charAt(i++));

                chr1 = (enc1 << 2) | (enc2 >> 4);
                chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
                chr3 = ((enc3 & 3) << 6) | enc4;

                output = output + String.fromCharCode(chr1);

                if (enc3 != 64) {
                    output = output + String.fromCharCode(chr2);
                }
                if (enc4 != 64) {
                    output = output + String.fromCharCode(chr3);
                }

                chr1 = chr2 = chr3 = "";
                enc1 = enc2 = enc3 = enc4 = "";

            } while (i < input.length);

            return output;
        }
    };
});

App.factory('RecursionHelper', ['$compile', function($compile) {
    return {
        /**
         * Manually compiles the element, fixing the recursion loop.
         * @param element
         * @param [link] A post-link function, or an object with function(s) registered via pre and post properties.
         * @returns An object containing the linking functions.
         */
        compile: function(element, link) {
            // Normalize the link parameter
            if (angular.isFunction(link)) {
                link = { post: link };
            }

            // Break the recursion loop by removing the contents
            var contents = element.contents().remove();
            var compiledContents;
            return {
                pre: (link && link.pre) ? link.pre : null,
                /**
                 * Compiles and re-adds the contents
                 */
                post: function(scope, element) {
                    // Compile the contents
                    if (!compiledContents) {
                        compiledContents = $compile(contents);
                    }
                    // Re-add the compiled contents to the element
                    compiledContents(scope, function(clone) {
                        element.append(clone);
                    });

                    // Call the post-linking function, if any
                    if (link && link.post) {
                        link.post.apply(null, arguments);
                    }
                }
            };
        }
    };
}]);

App.service('AuthInterceptor', function($q, $location, $cookies, $rootScope, $cacheFactory) {
    var service = this;
    service.responseError = function(response) {
        if (response.status == 401) {
            if ($cookies.get('LOGGED_IN') == 'true') {
                $cookies.put('LOGGED_IN', false, {
                    path: '/'
                });
            }
            $rootScope.loading = false;
            $cookies.put('LOGGED_IN', null, {
                path: '/'
            });
            $rootScope.AUTH_CHECK = false;
            $cacheFactory.get('$http').removeAll();
            $location.path('login');
            return false;
        }
        return $q.reject(response);
    };
});

App.directive('appHeader', function() {
    var bool = {
        'true': true,
        'false': false
    };
    return {
        restrict: 'E',
        link: function(scope, element, attrs) {
            attrs.$observe('authenticated', function(newValue, oldValue) {
                if (bool[newValue]) { scope.headerUrl = 'assets/views/includes/authenticated.html'; } else { scope.headerUrl = 'assets/views/includes/not-authenticated.html'; }
            });
        },
        template: '<div class="application-container" ng-include="headerUrl"></div>'
    }
});

App.directive('compile', ['$compile', function($compile) {
    return function(scope, element, attrs) {
        scope.$watch(
            function(scope) {
                return scope.$eval(attrs.compile);
            },
            function(value) {
                element.html(value);
                $compile(element.contents())(scope);
            }
        );
    };
}]);

App.directive('compileUnsafe', function($compile) {
    return function(scope, element, attr) {
        scope.$watch(attr.compileUnsafe, function(val, oldVal) {
            if (!val || (val === oldVal && element[0].innerHTML)) return;
            element.html(val);
            $compile(element)(scope);
        });
    };
});

App.directive("strToTime", function() {
    "use strict";
    return {
        require: 'ngModel',
        link: function(scope, element, attrs, ngModelController) {
            ngModelController.$parsers.push(function(data) {
                if (!data) {
                    return "";
                }
                return ("0" + data.getHours().toString()).slice(-2) + ":" + ("0" + data.getMinutes().toString()).slice(-2);
            });
            ngModelController.$formatters.push(function(data) {
                if (!data) {
                    return null;
                }
                var d = new Date(1970, 1, 1);
                var splitted = data.split(":");
                d.setHours(splitted[0]);
                d.setMinutes(splitted[1]);
                return d;
            });
        }
    };
});

App.directive('ckeditor', () => {
    return {
        require: '?ngModel',
        link: function(scope, element, attr, ngModel) {
            if (!ngModel) return;
            ClassicEditor
                .create(element[0], {
                    ckfinder: {
                        uploadUrl: 'service/api/uploadCkeditor'
                    }
                })
                .then(editor => {
                    editor.model.document.on('change:data', () => {
                        ngModel.$setViewValue(editor.getData());
                        // Only `$apply()` when there are changes, otherwise it will be an infinite digest cycle
                        if (editor.getData() !== ngModel.$modelValue) {
                            scope.$apply();
                        }
                    });
                    ngModel.$render = () => {
                        editor.setData(ngModel.$modelValue);
                    };
                    scope.$on('$destroy', () => {
                        editor.destroy();
                    });
                });
        }
    };
});

App.directive('tickottyReady', function() {
    "use strict";
    return {
        link: function($scope) {
            setTimeout(function() {
                $scope.$apply(function() {
                    angular.element(document).ready(function() {

                        //

                    });
                });
            }, 1000);
        }
    };
});

App.directive("bindExpression", function($parse) {
    "use strict";
    var directive = {};
    directive.restrict = 'E';
    directive.require = 'ngModel';
    directive.link = function(scope, element, attrs, ngModel) {
        scope.$watch(attrs.expression, function(newValue) {
            ngModel.$setViewValue(newValue);
        });
        ngModel.$render = function() {
            $parse(attrs.expression).assign(ngModel.viewValue);
        };
    };
    return directive;
});

App.directive('tickottyDraggable', function() {
    return {
        restrict: 'A',
        link: function(scope, elm, attrs) {
            var options = scope.$eval(attrs.tickottyDraggable); //allow options to be passed in
            elm.draggable(options);
        }
    };
});