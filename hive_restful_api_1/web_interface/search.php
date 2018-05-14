<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Response Page</title>
<!--
Strategy Template
http://www.templatemo.com/tm-489-strategy
-->
    <!-- load stylesheets -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400">  <!-- Google web font "Open Sans" -->
    <link rel="stylesheet" href="font-awesome-4.5.0/css/font-awesome.min.css">                <!-- Font Awesome -->
    <link rel="stylesheet" href="css/bootstrap.min.css">                                      <!-- Bootstrap style -->
    <link rel="stylesheet" href="css/hero-slider-style.css">                                  <!-- Hero slider style -->
    <link rel="stylesheet" href="css/templatemo-style.css">                                   <!-- Templatemo style -->

</head>
<?php
$name=$_GET["name"];
$count=$_GET["count"];
$startdate = $_GET["startdate"];
$enddate = $_GET["enddate"];
if ($startdate==""){
    $startdate = "none";
}
if ($enddate==""){
    $enddate = "none";
}
?>
<body>
        <section class="tm-section tm-section-3 tm-bg-purple">
            <div class="container-fluid tm-section-3-inner">
                <div class="row center-block text-xs-center tm-section-3-header">
                    <div class="col-xs-12">
                        <h2 class="tm-text-white tm-section-3-title"><?php echo $name; ?> for your request</h2>
                        <p class="tm-text-white tm-section-3-description">Following table shows the answer for your requests generated from twitter data set streamed by Apache Flume and quiried by Hive</p>      
                    </div>
                </div>
                <div class="row">                    
                    
                    <div class="tm-plan-boxes-container">

                            <table class="tm-plan">
                                <thead>
                                    <tr><?php
										if ($name == 'retweet' || $name == 'favorite'){
											echo"
                                        <th class=\"text-xs-center tm-plan-table-header\">Time</th>
                                        <th class=\"text-xs-center tm-plan-table-header\">User</th>
                                        <th class=\"text-xs-center tm-plan-table-header\">Text</th>
                                        <th class=\"text-xs-center tm-plan-table-header\">Count</th>
										";
										}
										else if ($name == 'user_mentions'){
											echo "<th class=\"text-xs-center tm-plan-table-header\">User</th>
	                                        <th class=\"text-xs-center tm-plan-table-header\">Count</th>";
										}
										else if ($name == 'hash_tags'){
											echo "<th class=\"text-xs-center tm-plan-table-header\">Hash Tag</th>
	                                        <th class=\"text-xs-center tm-plan-table-header\">Count</th>";
										}
										?>
                                    </tr>
                                </thead>
                                <tbody class="tm-bg-light-orange">
                                <?php
                                if(is_numeric($count)){
                                    $url="10.231.43.99:8787/$name/$count/$startdate/$enddate";
                                    $ch = curl_init();
                                    curl_setopt($ch, CURLOPT_URL,$url);
                                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                                    $content = curl_exec($ch);
                                    curl_close ($ch);
									$content = str_replace(array('"', "'"), '', $content);
									$data = explode('\n', $content);
									array_pop($data);
									for ($i = 0; $i < sizeof($data); $i++) {
                                    	$dd = explode('\t', $data[$i]);    
										if ($name == 'retweet' || $name == 'favorite'){
											if (sizeof($dd)<4){
												$data[$i+1]=$data[$i].'\n'.$data[$i+1];
												continue;
											}
										}                                    
                                    	echo "<tr>";
                                    	foreach($dd as $ddd){
                                    		echo "<td style=\" padding: 20px; border: 1px solid #ddd;\">";
                                       		$jdata = json_decode('"'.$ddd.'"');
											echo $jdata;
                                       	 	echo "</td>"; 	
                                    	}
                                    	echo "</tr>";
                                	}
                                }
                                else {
                                    echo("<script>alert('Quantity must be integer')</script>");
                                    echo("<script>window.location = 'index.html';</script>");
                                }
								?>                  
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td class="text-xs-center">
                                            <a href="index.html" class="tm-plan-link tm-plan-link-orange">Back</a>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table> 


                    </div> <!-- tm-plan-boxes-container -->
            
                </div>
            </div>            
        </section>

</body>
</html>

