<?php include './app/Config.php'; ?>
<!DOCTYPE html>
<html>

<head>
	<title>Tickotty™ | Installation Wizard
		<?= (!empty($title) ? $title : null) ?>
	</title>
	<!-- Favicon -->
	<link rel="icon" href="../../assets/img/logo.png" type="image/png">
	<!-- Bootstrap -->
	<link rel="stylesheet" href="public/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="public/css/font-awesome.min.css">
	<!-- Custom Style -->
	<link rel="stylesheet" href="public/css/style.css">
	<style>
		body {
			background: white;
		}
	</style>
</head>
<body>
	<!-- BACK TO TOP  -->
	<a name="top"></a>
	<!-- BEGIN CONTAINER -->
	<div class="container">
		<!-- BEGIN ROW -->
		<div class="row">
			<div class="col-md-12">
				<!-- MAIN WRAPPER -->
				<div class="main_wrapper">
					<!-- BEGIN HEADER -->
					<div class="logo text-center">
					<img width="20%" style="margin-bottom: 20px;margin-top: 20px;" src="../../assets/img/app-logo.png" alt="">
					</div>
					<!-- ENDS HEADER -->
					<div class="col-md-12">
						<!-- ENDS LEFT SIDEBAR -->
						<!-- BEGIN CONTENT -->
						<div class="col-sm-12">
							<div class="content">
								<?php include($content) ?>
							</div>
						</div>
						<!-- ENDS CONTENT -->
					</div>
				</div>
				<!-- END MAIN WRAPPER -->
			</div>
		</div>
		<!-- ENDS ROW -->
	</div>
	<!-- ENDS OF CONTAINER -->
	<!-- ALL SCRIPTS/JS -->
	<script src="public/js/jquery.min.js"></script>
	<script src="public/js/script.js"></script>
</body>

</html>