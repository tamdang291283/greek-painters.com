<!DOCTYPE html>
<html>

<head>
	<title>Ordering Page</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="order-page2/css/fonts.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="order-page2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="order-page2/css/bootstrap-theme.css">
    <link rel="stylesheet" href="order-page2/css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" type="text/css" href="order-page2/css/css-glory.css">

	<link rel="stylesheet" href="order-page2/css/style.min.css">
	<link rel="stylesheet" href="order-page2/css/jquery-gmaps-latlon-picker.css">
	<link rel="stylesheet" type="text/css" href="order-page2/css/custom.css">
	<link rel="stylesheet" type="text/css" href="order-page2/css/icon.css">
	<link rel="stylesheet" type="text/css" href="order-page2/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="order-page2/css/jPushMenu.css">

	<link rel="stylesheet" type="text/css" href="order-page2/css/custom.style.css">


	
	<script type="text/javascript" src="order-page2/js/jquery-1.12.1.js"></script>
	<script src="order-page2/js/jquery-ui.js"></script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6UClz42ItbSc2_uRdpdGCi5GfRhE-1iA"></script>
	<script type="text/javascript" src="order-page2/js/bootstrap.min.js"></script>

	<script type="text/javascript" src="order-page2/js/moment.min.js"></script>
    <script src="order-page2/js/moment.js"></script>
	<script type="text/javascript" src="order-page2/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="order-page2/js/menu.min.js"></script>
	<script type="text/javascript" src="order-page2/js/jPushMenu.js"></script>
	<script type="text/javascript" src="order-page2/js/custom.js"></script>
	<script type="text/javascript" src="order-page2/js/locationpicker.js"></script>

	<script type="text/javascript" src="order-page2/js/sticky.js"></script>
	

</head>

<body>

	<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left">
		<div class="hidden-menu-width hidden-menu-info">
			<button class="hidden-menu-close">Close</button>
			<ul class="menu-left-slide">
				<li><a href="https://www.google.co.uk/maps?q=67 - 71 Slateford Road, Edinburgh, EH11 1PR" class="header-phone"><i class="glyphicon glyphicon-earphone"></i>0131 313 5588</a></li>
				<li><a href="mailto:k9kondop@hotmail.com" class="header-email"><i class="glyphicon glyphicon-envelope"></i>k9kondop@hotmail.com</a></li>
				<li><a href="tel:0131 313 5588" class="header-address"><i class="glyphicon glyphicon-globe"></i>67 - 71 Slateford Road, Edinburgh, EH11 1PR</a></li>
				<li style="margin-top:20px;"><span class="day"><b>Opening times</b></li>
			<li><span class="day day-left">Monday</span><span class="hour hour-right">12:00 - 23:55</span></a>
				</li>
				<li><span class="day day-left">Tuesday</span><span class="hour hour-right">12:00 - 21:30</span></li>
				<li><span class="day day-left">Wednesday</span><span class="hour hour-right"><img src="order-page2/Images/no-delivery.gif" class="img-no-delivery" width="18" data-toggle="tooltip" data-placement="left" title="" data-original-title="Delivery is not available during this time slot">19:00 - 23:59</span></li>
				<li><span class="day day-left">Thursday</span><span class="hour hour-right"><img src="order-page2/Images/no-delivery.gif" class="img-no-delivery" width="18" data-toggle="tooltip" data-placement="left" title="" data-original-title="Delivery is not available during this time slot">16:30 - 23:59</span></li>
				<li><span class="day day-left">Friday</span><span class="hour hour-right">12:00 - 23:59</span></li>
				<li><span class="day day-left">Saturday</span><span class="hour hour-right">22:20 - 01:15</span></li>
				<li><span class="day day-left">Sunday</span><span class="hour hour-right">22:30 - 23:00</span></li>
			</ul>
		</div>
	</nav>

	<nav id="c-menu--slide-left" class="c-menu c-menu--slide-left hidden-menu-info">
		<button class="c-menu__close">Close</button>
		<ul class="c-menu__items menu-left-slide">
			<li class="c-menu__item"><a href="https://www.google.co.uk/maps?q=67 - 71 Slateford Road, Edinburgh, EH11 1PR" class="header-phone"><i class="glyphicon glyphicon-earphone"></i>0131 313 5588</a></li>
			<li class="c-menu__item"><a href="#" class="header-email"><i class="glyphicon glyphicon-envelope"></i>k9kondop@hotmail.com</a></li>
			<li class="c-menu__item"><a href="tel:0131 313 5588" class="header-address"><i class="glyphicon glyphicon-globe"></i>67 - 71 Slateford Road, Edinburgh, EH11 1PR</a></li>
			<li class="c-menu__item" style="margin-top:20px;"><span class="day"><b>Opening times</b></li>
		<li class="c-menu__item"><span class="day day-left">Monday</span><span class="hour hour-right">12:00 - 23:55</span></a>
			</li>
			<li class="c-menu__item"><span class="day day-left">Tuesday</span><span class="hour hour-right">12:00 - 21:30</span></li>
			<li class="c-menu__item"><span class="day day-left">Wednesday</span><span class="hour hour-right"><img src="order-page2/Images/no-delivery.gif" class="img-no-delivery" width="18" data-toggle="tooltip" data-placement="left" title="" data-original-title="Delivery is not available during this time slot">19:00 - 23:59</span></li>
			<li class="c-menu__item"><span class="day day-left">Thursday</span><span class="hour hour-right"><img src="order-page2/Images/no-delivery.gif" class="img-no-delivery" width="18" data-toggle="tooltip" data-placement="left" title="" data-original-title="Delivery is not available during this time slot">16:30 - 23:59</span></li>
			<li class="c-menu__item"><span class="day day-left">Friday</span><span class="hour hour-right">12:00 - 23:59</span></li>
			<li class="c-menu__item"><span class="day day-left">Saturday</span><span class="hour hour-right">22:20 - 01:15</span></li>
			<li class="c-menu__item"><span class="day day-left">Sunday</span><span class="hour hour-right">22:30 - 23:00</span></li>
		</ul>
	</nav>
	<div id="c-mask" class="c-mask"></div>
	<header>
		<div class="header-opacity-background">
			<div class="container">
				<div class="hidden-menu-icon">
					<button class="toggle-menu menu-left"><span
						class="glyphicon glyphicon-menu-hamburger"></span><span>Info</span></button>

				</div>
				<div class="tel-address">
					<a href="https://www.google.co.uk/maps?q=67 - 71 Slateford Road, Edinburgh, EH11 1PR" class="header-phone"><i class="glyphicon glyphicon-earphone"></i>0131 313 5588</a>
					<a href="mailto:k9kondop@hotmail.com" class="header-email"><i class="glyphicon glyphicon-envelope"></i>k9kondop@hotmail.com</a>
					<a href="tel:0131 313 5588" class="header-address"><i class="glyphicon glyphicon-globe"></i>67 - 71 Slateford Road,
					Edinburgh, EH11 1PR</a>
				</div>
				<div class="center-logo">
					<img src="order-page2/images/web-logo3.jpg" alt="logo" title="logo">
				</div>
				<div class="open-hour">
					<a class="open-dropdown" href="#">Opening Times <i class="glyphicon glyphicon glyphicon-menu-down"></i></a>
					<div class="times-box">
						<span id="times-close">X</span>
						<ul>

							<li class="times-item"><span class="day">Monday</span><span class="hour">12:00 - 23:55</span>
							</li>
							<li class="times-item"><span class="day">Tuesday</span><span class="hour">
								<img src="order-page2/Images/no-delivery.gif" class="img-no-delivery" width="18" data-toggle="tooltip" data-placement="left" title="" data-original-title="Delivery is not available during this time slot">12:00 - 21:30
							</span>
							</li>
							<li class="times-item"><span class="day">Wednesday</span><span class="hour">
								<img src="order-page2/Images/no-delivery.gif" class="img-no-delivery"  width="18" data-toggle="tooltip" data-placement="left" title="" data-original-title="Delivery is not available during this time slot">19:00 - 23:59
							</span>
							</li>
							<li class="times-item"><span class="day">Thursday</span><span class="hour">16:30 - 23:59</span>
							</li>
							<li class="times-item"><span class="day">Friday</span><span class="hour">12:00 - 23:59</span>
							</li>
							<li class="times-item"><span class="day">Saturday</span><span class="hour">22:20 - 01:15</span>
							</li>
							<li class="times-item"><span class="day">Sunday</span><span class="hour">22:30 - 23:00</span>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</header>
	<div class="container" id="categories-hidden-menu">
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					 aria-expanded="false">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
					<a class="navbar-brand" href="#">Categories</a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li><a class="scroll-nav-link" href="#meal-deals-menu">Meal Deals</a></li>
						<li><a class="scroll-nav-link" href="#starter-menu">Starter</a></li>
						<li><a class="scroll-nav-link" href="#">Demo Link</a></li>
						<li><a class="scroll-nav-link" href="#">Demo Link</a></li>
						<li><a class="scroll-nav-link" href="#">Demo Link</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>
	</div>
	<div class="container" id="main-container">
		<h1 class="start-logo">Start your order</h1>
		<div class="row">

			<form class="clearfix main-container__inner">
				<div class="col-md-9" id="menu-list-box">

					<div id="accordion-order" class="menu-box">
						<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
							<!-- collapseOne -->
							<div id="meal-deals-menu" class="panel panel-default pannel-item">
								<div class="panel-heading panel-header-shown" role="tab" id="headingOne">
									<h4 class="panel-title panel-header">
										<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
										<span class="pull-right"><i class="arrow_carrot-2down"></i></span>
										Meal Deals
									</a>
									</h4>
								</div>
								<div id="collapseOne" class="panel-collapse collapse in panel-collapse-item" role="tabpanel" aria-labelledby="headingOne">
									<div class="panel-body panel-content">
										<div class="row content-item">
											<div class="col-md-11 col-sm-11 col-xs-11 dish-name-thumbnails">
												<h4><span class="dish-name">Any pizza, any size (VALID MONDAY - THURSDAY)</span><span class="price-from">VALID MONDAY - THURSDAY</span></h4>
												<p class="text-price">from £7.5</p>
											</div>
											<div class="col-md-1 col-sm-1 col-xs-1 content-item-price">
												<a href="#modalMenuOption" data-toggle="modal" class="has-children-plus">
												<i class="fa fa-plus-circle" aria-hidden="true"></i>
											</a>
											</div>
										</div>
										<div class="row content-item">
											<div class="col-md-11 col-sm-11 col-xs-11 dish-name-thumbnails">
												<h4><span class="dish-name">Buy 1 pizza, Get 1 free (Collection Only, VALID MONDAY - THURSDAY)</span><span class="price-from">Collection Only, VALID MONDAY - THURSDAY</span></h4>
												<p class="text-price">from £3.65</p>
											</div>
											<div class="col-md-1 col-sm-1 col-xs-1  content-item-price">
												<a href="#" class="no-children-plus">
												<i class="fa fa-plus-circle" aria-hidden="true"></i>
											</a>
											</div>
										</div>
										<div class="row content-item">
											<div class="col-md-11 col-sm-11 col-xs-11 dish-name-thumbnails">
												<h4><span class="dish-name">Family meal deal</span><span class="price-from">Any 2 pizzas, 2 starters, 2 sides, and bottle of drink</span></h4>
												<p class="text-price">from £25</p>
											</div>
											<div class="col-md-1 col-sm-1 col-xs-1  content-item-price">
												<a href="#" class="no-children-plus">
												<i class="fa fa-plus-circle" aria-hidden="true"></i>
											</a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- End collapseOne -->
							<!-- collapseTwo -->
							<div id="starter-menu" class="panel panel-default pannel-item">
								<div class="panel-heading panel-header-hidden" role="tab" id="headingTwo">
									<h4 class="panel-title">
										<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false"
										 aria-controls="collapseTwo">
										<span class="pull-right"><i class="arrow_carrot-2down"></i></span>
										Starters
									</a>
									</h4>
								</div>
								<div id="collapseTwo" class="panel-collapse collapse panel-collapse-item" role="tabpanel" aria-labelledby="headingTwo">
									<div class="panel-body panel-content">
										<div class="row content-item">
											<div class="col-md-11 col-sm-11 col-xs-11 dish-name-thumbnails">
												<h4><span class="dish-name">Any pizza, any size (VALID MONDAY - THURSDAY)</span><span class="price-from">VALID MONDAY - THURSDAY</span></h4>
												<p class="text-price">from £7.5</p>
											</div>

											<div class="col-md-1 col-sm-1 col-xs-1 content-item-price">
												<a data-toggle="modal" href="#modalMenuOption" class="has-children-plus"><i class="fa fa-plus-circle" aria-hidden="true"></i></a>
											</div>
										</div>
										<div class="row content-item">
											<div class="col-md-11 col-sm-11 col-xs-11 dish-name-thumbnails ">
												<h4><span class="dish-name">Buy 1 pizza, Get 1 free (Collection Only, VALID MONDAY - THURSDAY)</span><span class="price-from">Collection Only, VALID MONDAY - THURSDAY</span></h4>
												<p class="text-price">from £7.5</p>
											</div>
											<div class="col-md-1 col-sm-1 col-xs-1  content-item-price">
												<a href="#" class="no-children-plus"><i class="fa fa-plus-circle" aria-hidden="true"></i></a>
											</div>
										</div>
										<div class="row content-item">
											<div class="col-md-11 col-sm-11 col-xs-11 dish-name-thumbnails ">
												<h4><span class="dish-name">Family meal deal</span><span class="price-from">Any 2 pizzas, 2 starters, 2 sides, and bottle of drink</span></h4>
												<p class="text-price">from £25</p>
											</div>
											<div class="col-md-1 col-sm-1 col-xs-1  content-item-price">
												<a href="#" class="no-children-plus"><i class="fa fa-plus-circle" aria-hidden="true"></i></a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--End collapseTwo -->

							<div>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
								Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
								aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
								occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor
								sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
								ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
								dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
								non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur
								adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
								nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
								in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
								in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit,
								sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
								ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit
								esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
								deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
								incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
								ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
								eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
								anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut
								labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
								ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
								pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
								Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
								aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
								Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur
								sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum
								dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
								Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
								aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
								occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor
								sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
								ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
								dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
								non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur
								adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
								nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
								in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
								in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit,
								sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
								ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit
								esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
								deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
								incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
								ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
								eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
								anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut
								labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
								ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
								pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
								Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
								aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
								Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur
								sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum
								dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
								Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
								aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
								occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor
								sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
								ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
								dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
								non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur
								adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
								nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit
								in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt
								in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit,
								sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
								ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit
								esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia
								deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
								incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
								ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore
								eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
								anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut
								labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
								ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
								pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3 thumbnail-order-box" id="order-box">
					<div class="order-box">
						<!-- header select -->
						<div class="thumbnail-cart-title">
							<h3 class="cart-title">
								Your Order
							</h3>
						</div>
						<!-- end header select -->
						<hr class="border_top border-top-header">

						<div id="your-basket" class="bg_order-basket">
							<div class="order-basket">
								<h4><i class="glyphicon glyphicon-shopping-cart"></i>YOUR BASKET</h4>
								<b><p id="no-item-message"></p></b>
								<div class="list_product_add">
									<ul>
										<li class="cart-item">
											<i class="fa fa-2x fa-minus-square-o remove-cart-item"></i>
											<p>Vegetable Soup <span>£9.00</span></p>
										</li>

										<li class="cart-item">
											<i class="fa fa-2x fa-minus-square-o remove-cart-item"></i>
											<p>Spagetti<span>£9.00</span></p>
										</li>

										<li class="cart-item">
											<i class="fa fa-2x fa-minus-square-o remove-cart-item"></i>
											<p>Large Raviola<span>£9.00</span></p>
										</li>
									</ul>
									<div class="total">
										<p class=" padding_col">Subtotal
											<span class=" padding_col total-item ">£15.04</span></p>
										<p class="padding_col">Delivery
											<span class=" padding_col total-item">£2.00</span></p>
										<p style="font-size:18px;"><strong class=" padding_col">Total:</strong>
											<span class=" padding_col total-item total_price">£27.00</span></p>
										<!-- button special instructions -->
										<div class="panel-group instruction-group" id="accordionSpecial">
											<div class="panel panel-default instruction-default">
												<div class="panel-heading instruction-heading-hide">
													<h4 class="panel-title instruction-title">
														<i id="instruction-icon" class="fa fa-plus" aria-hidden="true"></i>
														<a data-toggle="collapse" data-parent="#accordion" href="#collapseSpecial">
										        
										          	Special Instructions
										        </a>
													</h4>
												</div>
												<div id="collapseSpecial" class="panel-collapse collapse instruction-colapse">
													<div class="panel-body instruction-body">
														<textarea id="valueInstruction" class="instruction-content">Special Instruction...</textarea>
													</div>
												</div>
											</div>
										</div>
										<!--end button special instructions -->
										<button type="button" class="btn waves-effect btn-placeorder btn-checkout" data-toggle="modal" data-target="#modal-order-type">Place Order</button>
									</div>
									<!-- end total -->
								</div>
							</div>
						</div>

					</div>
					<!-- voucher-box -->
					<div class=" voucher-box">
						<div class="voucher-code">
							<h4>VOUCHER CODE</h4>
							<div class="input-group">
								<input type="text" class="form-control" placeholder="Enter code">
								<span class="input-group-btn">
								<button class="btn btn-secondary" type="button">Submit</button>
							</span>
							</div>
						</div>
					</div>
					<!-- end voucher-box -->
				</div>
				<!-- end order-box -->
			</form>
		</div>

	</div>

	<div class="modal fade" id="modalMenuOption" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-order-thumbnails">
			<div class="modal-content">
				<div class="modal-header modal-order-header">
					<button type="button" class="close" data-dismiss="modal"><span class="modal-order-icon-close"
																			   aria-hidden="true">&times;</span><span
						class="sr-only">Close</span></button>
					<h4 class="modal-title modal-order-title" id="ModalTitle-1-1">- Buy 1 pizza, Get 1 free (Collection Only, VALID MONDAY - THURSDAY)</h4>
				</div>
				<div class="modal-body modal-order-body">
					<form>
						<p class="select-name">Pizza</p>
						<select id="select-1" class="form-control">
						<option selected="true" disabled="true">--You must select an option *--</option>
						<option>Extra large &euro;20</option>
						<option>Large &euro;15</option>
						<option>Medium &euro;10</option>
						<option>Small &euro;5</option>
					</select>
						<p class="select-name">Topping</p>
						<select id="select-2" class="form-control" style="margin-bottom: 15px;">
						<option selected="true" disabled="true">--You must select an option *--</option>
						<option>Cheese &euro;0</option>
						<option>Bacon &euro;0</option>
						<option>Pepper &euro;0</option>
						<option>Sausage &euro;0</option>
						<option>Seafood &euro;0</option>
					</select>
						<div id="ChoseOrder" class="btn-group btn-group row" data-toggle="buttons">
							<div class="col-md-3 col-sm-4 col-xs-6 btn-choseOrder-thumbnails">
								<label class="btn btn-choseOrder active">
						          <input type="radio" name='radioOption1' checked><i class="fa fa-circle-o fa-2x"></i><i class="fa fa-dot-circle-o fa-2x"></i> <span>Demo Radio Option 1</span>
						        </label>
							</div>
							<div class="col-md-3 col-sm-4 col-xs-6 btn-choseOrder-thumbnails">
								<label class="btn btn-choseOrder">
						          <input type="radio" name='radioOption1'><i class="fa fa-circle-o fa-2x"></i><i class="fa fa-dot-circle-o fa-2x"></i><span>Demo Radio Option 2</span>
						        </label>
							</div>


						</div>

						<div class="btn-group btn-group row" data-toggle="buttons">
							<div class="col-md-3 col-sm-4 col-xs-6 btn-choseOrder-thumbnails">
								<label class="btn btn-choseOrder active">
							      <input type="checkbox" name='checkbox1' checked><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span>Demo Check Option 1
							    </label>
							</div>

							<div class="col-md-3 col-sm-4 col-xs-6 btn-choseOrder-thumbnails">
								<label class="btn btn-choseOrder">
							      <input type="checkbox" name='checkbox2'><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span>Demo Check Option 2</span>
							    </label>
							</div>

							<div class="col-md-3 col-sm-4 col-xs-6 btn-choseOrder-thumbnails">
								<label class="btn btn-choseOrder">
							      <input type="checkbox" name='checkbox3'><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i><span>Demo Check Option 3</span>
							    </label>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer modal-order-footer">
					<button id="add-to-order" type="button" class="close btn btn-primary btn-add-order" data-dismiss="modal">ADD TO ORDER</button>
				</div>
			</div>
		</div>
	</div>


	<footer>
		<a href="#your-basket" class="btn basket-footer-btn scroll"><i></i>Your Basket &euro;19</a>
	</footer>

	<div id="hidden-map" style="background:#f9f9f9;top:100%;height:100%;z-index:9999;position:fixed;width:100%;text-align:center;">
		<div style="height:90%;overflow:auto">
			<fieldset class="gllpLatlonPicker">
				<p>Type a location name or mark it on the map:</p>
				<input id="location-map-input" type="text" class="gllpLocationName gllpSearchField" size=42/><br/>
				<input type="button" class="gllpSearchButton" value="search">
				<br/>
				<br>
				<button id="mark-location" class="close-map">Mark My Coordinates</button>
				<button class="close-map">Cancel</button>
				<br>
				<div style="margin:0 auto;width:100%;height:350px;padding:0 15px;" class="gllpMap">Google Maps</div>
				<br/>
				<input type="hidden" class="gllpZoom" value="3" />
				<br/>
				<input type="hidden" class="gllpLatitude" />
				<input type="hidden" class="gllpLongitude" />
				<input type="hidden" class="gllpZoom" />

			</fieldset>
		</div>
	</div>

	<!-- Modal OrderType #lt-->
	<div class="modal fade" id="modal-order-type" tabindex="-1" role="dialog" aria-labelledby="Menu Order" aria-hidden="true">
		<div class="modal-dialog modal-dialog-order-type" role="document">
			<div class="modal-content">
				<div class="modal-header modal-order-type__header">
					<button type="button" class="close" data-dismiss="modal"><span class="modal-order-icon-close"
																			   aria-hidden="true">&times;</span><span
						class="sr-only">Close</span></button>
					<h4 class="modal-title"><span class="glyphicon glyphicon-time"></span> Order type</h4>
				</div>
				<div class="modal-body modal-order-type__body">
					<!-- radio delivery- collection -->
					<div id="deliveryOption" class="thumbnails-radio-DeliveryCollection delivery-option">
						<label id="delivery1" class="btn btn-choseOrder">
					    <input  class="delivery-collection" type="radio" name="optionsDeliveryCollection"  value="optionsDelivery" checked="" onclick="showDelivery();"><i class="fa fa-circle-o"></i><i class="fa fa-dot-circle-o"></i> <span>Delivery<span>Approx: 45min</span></span>
				  	</label>
						<label id="collection1" class="btn btn-choseOrder">
					    <input class="delivery-collection" type="radio" name="optionsDeliveryCollection"  value="optionCollection" onclick="hideDelivery();"><i class="fa fa-circle-o"></i><i class="fa fa-dot-circle-o"></i><span>Collection<span>Approx: 30min</span></span>
				  	</label>
					</div>
					<!-- end radio delivery- collection -->

					<div class="enter_postcode">

					</div>
					<!-- end deviver-option -->

					<hr class="border_top">

					<!-- radio now late -->
					<div id="tabs" class=" thumbnails-radio-NowLate ">
						<!-- tab-now -->
						<div class="tab ">
							<input id="tabNow" class="now-late" type="radio" name="optionsNowLate" value="optionsNow" checked="" onclick="hideLate();">
							<label for="tabNow">Now</label>

							<!-- for id="optionsRadiosNow"  -->
							<div id="optionsRadiosNow" class="content options-now box1 optionsNow">
								<p style="font-weight:700;">Earliest delivery time: 7:55 PM.</p>
								<p>Please proceed with your order</p>
							</div>
							<!-- end id optionsRadiosNow  -->
						</div>
						<!-- end tab-now -->

						<!-- tab-late -->
						<div class="tab ">
							<input id="tabLate" class="now-late" type="radio" name="optionsNowLate" value="optionLate" onclick="showLate();">
							<label for="tabLate">Late</label>

							<!-- for id="optionsRadiosLate"  -->
							<div id="optionsRadiosLate" class="content box1 optionLate">
								<p class="please-select">Please select Delivery Time*</p>
								<div class="form-group">
									<div class='input-group date input-datetime ' id='datetimepicker1' style=" float:left">
										<input type='text' class="form-control input-datetime-picker" />
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>

									<div class="input-group input-datetime">
										<select class="form-control select_one">
										<option>15</option>
										<option>16</option>
										<option>18</option>
										<option>19</option>
										<option>20</option>
										<option>21</option>
										<option>22</option>
										<option>23</option>
									</select>
										<select class="form-control select_two">
										<option>00</option>
										<option>05</option>
										<option>10</option>
										<option>15</option>
										<option>20</option>
										<option>25</option>
										<option>30</option>
										<option>35</option>
										<option>40</option>
										<option>45</option>
										<option>50</option>
										<option>55</option>
									</select>
									</div>
								</div>
							</div>
							<!-- end id optionsRadiosLate -->
						</div>
						<!-- end tab-late -->
					</div>

					<div id="divDelivery">
						<hr class="border_top">

						<!-- Delivery postcode -->
						<div class="delivery-postcode  ">
							<h4>Delivery Postcode</h4>
							<div class="input-group group-absolute">
								<input id="location-input" type="text" class="form-control" placeholder="EXAMPLE: tSK14 1HY">
								<span class="input-group-btn">
									<button class="btn btn-secondary" type="button">Check</button>
								</span>
							</div>
							<div class="check-location-danger">
								<p><span>Check</span> delivery in available <br>then click <span>Place Order</span> to continue</p>
							</div>
							<a id="picklocation" href="#"><i class="fa fa-location-arrow" aria-hidden="true"></i>Pick a Location</a>
							<div class="check-location-info">
								<p>Delivery Change: £2 for over 1km</p>
								<p>Max. delivery distance: 5km</p>
								<p>Free delivery up to: 1km</p>
								<p>Minimum Order: £10</p>
							</div>
						</div>
						<!-- end Delivery postcode -->
					</div>
				</div>
				<div class="modal-footer modal-order-type__footer">
					<button class="btn btn-large waves-effect btn-custom-primary btn-back-to-menu pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-chevron-left"></span>Back to menu</button>
					<button id="add-to-order" type="button" class="btn btn-large waves-effect btn-custom-primary pull-right" data-dismiss="modal">Continue</button>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		// var slideLeft = new Menu({
		//     wrapper: '#o-wrapper',
		//     type: 'slide-left',
		//     menuOpenerClass: '.c-button',
		//     maskId: '#c-mask'
		//  	});

		//  	var slideLeftBtn = document.querySelector('#c-button--slide-left');

		// slideLeftBtn.addEventListener('click', function(e) {
		//    	e.preventDefault;
		//    	slideLeft.open();
		//  	});
		$(document).ready(function () {
			$('#myModal').modal();
			$('.toggle-menu').jPushMenu();
		});

	</script>
	</script>
</body>

</html>