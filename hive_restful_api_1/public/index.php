<?php
$autoloadroute = '/Users/jeanhsu/Documents/hive_restful_api_1/vendor/autoload.php';
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
require $autoloadroute;

$app = new \Slim\App;
$app->get('/{name}/{count}/{startdate}/{enddate}', function (Request $request, Response $response, array $args) {
    $name = $args['name'];
	$count= $args['count'];
	$startdate = $args['startdate'];
	$enddate = $args['enddate'];
	shell_exec( "/Users/jeanhsu/Documents/hive_restful_api_1/public/$name.sh $count $startdate $enddate");
	$output = shell_exec("cat /Users/jeanhsu/Documents/hive_restful_api_1/public/tmp/out2");
	shell_exec("rm /Users/jeanhsu/Documents/hive_restful_api_1/public/tmp/out2");
	//header('Content-type: text/html; charset=utf-8');
	echo json_encode($output);
});
$app->run();