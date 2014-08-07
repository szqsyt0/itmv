<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title>ITmv Admin</title>
<link rel="stylesheet" href="<?php echo base_url("resources/css/reset.css");?>" type="text/css" media="screen" />
<link rel="stylesheet" href="<?php echo base_url("resources/css/style.css");?>" type="text/css" media="screen" />
<link rel="stylesheet" href="<?php echo base_url("resources/css/invalid.css");?>" media="screen" />	
<script type="text/javascript" src="<?php echo base_url("resources/scripts/jquery-1.3.2.min.js");?>"></script>
<script type="text/javascript" src="<?php echo base_url("resources/scripts/simpla.jquery.configuration.js");?>"></script>
<script type="text/javascript" src="<?php echo base_url("resources/scripts/facebox.js");?>"></script>
<script type="text/javascript" src="<?php echo base_url("resources/scripts/jquery.wysiwyg.js");?>"></script>
<script type="text/javascript" src="<?php echo base_url("resources/scripts/jquery.datePicker.js")?>;"></script>
<script type="text/javascript" src="<?php echo base_url("resources/scripts/jquery.date.js");?>"></script>
</head>
	<body><div id="body-wrapper"> <!-- Wrapper for the radial gradient background -->
		
		<div id="sidebar">
            <div id="sidebar-wrapper">
              <!-- Sidebar with logo and menu -->
              <h1 id="sidebar-title"><a href="#">ITmv Admin</a></h1>
              <!-- Logo (221px wide) -->
              <a href="#"><img id="logo" src="<?php echo base_url("resources/images/logo.png")?>" alt="Simpla Admin logo" /></a>
              <!-- Sidebar Profile links -->
              <div id="profile-links"> 欢迎,<a href="#" title="Edit your profile">admin</a><br />
                <br />
                <a href="#" title="View the Site">前往首页</a> | <a href="#" title="Sign Out">退出</a> </div>
              <ul id="main-nav">
                <!-- Accordion Menu -->
                <li> <a href="#" class="nav-top-item current">
                  <!-- Add the class "current" to current menu item -->
                  视频管理 </a>
                    <ul>
                        <li><a class="current" href="#">所有视频</a></li>                       
                    </ul>
                </li>
                <li> <a href="#" class="nav-top-item"> 图片管理 </a>
                    <ul>
                        <li><a href="#">所有图片</a></li>                       
                    </ul>                   
                </li>
                <li> <a href="#" class="nav-top-item"> 专辑管理 </a>
                     <ul>
                        <li><a href="#">所有专辑</a></li>                       
                    </ul> 
                </li>
                <li> <a href="#" class="nav-top-item"> 分类管理</a>
                     <ul>
                         <li><a href="#">所有分类</a></li>                       
                    </ul> 
                </li>
                <li> <a href="#" class="nav-top-item"> 账号设置 </a>
                    <ul>
                        <li><a href="#">所有管理员</a></li>  
                        <li><a href="#">个人信息</a></li> 
                    </ul>
                </li>
              </ul>
              <!-- End #main-nav -->
            </div>
        </div>
  <!-- End #sidebar -->
		
		<div id="main-content"> <!-- Main Content Section with everything -->
			
			<noscript> <!-- Show a notification if the user has disabled javascript -->
				<div class="notification error png_bg">
					<div>
						你的浏览器不支持Javascript. 请 <a href="http://browsehappy.com/" title="Upgrade to a better browser">更新</a> 你的浏览器。
					</div>
				</div>
			</noscript>
			
			<!-- Page Head -->
			<h2>欢迎进入IT微视管理后台</h2>
			
			<ul class="shortcut-buttons-set">
				
				<li><a class="shortcut-button" href="#"><span>
					<img src="<?php echo base_url("resources/images/icons/paper_content_pencil_48.png");?>" alt="icon" /><br />
					创建分类
				</span></a></li>
				
				<li><a class="shortcut-button" href="#"><span>
					<img src="<?php echo base_url("resources/images/icons/image_add_48.png");?>" alt="icon" /><br />
					上传视频
				</span></a></li>
				
				<li><a class="shortcut-button" href="#"><span>
					<img src="<?php echo base_url("resources/images/icons/clock_48.png");?>" alt="icon" /><br />
					上传图片
				</span></a></li>
				
				<li><a class="shortcut-button" href="#messages" rel="modal"><span>
					<img src="<?php echo base_url("resources/images/icons/comment_48.png");?>" alt="icon" /><br />
					添加管理员
				</span></a></li>
				
			</ul><!-- End .shortcut-buttons-set -->
			
			<div class="clear"></div> <!-- End .clear -->
			
			<div class="content-box"><!-- Start Content Box -->
				
				<div class="content-box-header">
					
					<h3>视频列表</h3>
					
					<ul class="content-box-tabs">
						<li><a href="#tab1" class="default-tab">列表</a></li> <!-- href must be unique and match the id of target div -->
						<li><a href="#tab2">上传</a></li>
					</ul>
					
					<div class="clear"></div>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
					
					<div class="tab-content default-tab" id="tab1"> <!-- This is the target div. id must match the href of this div's tab -->
						
						<div class="notification attention png_bg">
							<a href="#" class="close"><img src="<?php echo base_url("resources/images/icons/cross_grey_small.png");?>" title="Close this notification" alt="close" /></a>
							<div>
								这里是视频列表，你可以在这里管理视频
							</div>
						</div>
						<table>
							<thead>
                                                            <tr>
                                                              <th>
                                                                <input class="check-all" type="checkbox" />
                                                              </th>
                                                              <th>名称</th>
                                                              <th>专辑</th>
                                                              <th>类别</th>               
                                                              <th>简介</th>
                                                              <th>操作</th>
                                                            </tr>
                                                          </thead>
							<tfoot>
								<tr>
									<td colspan="6">
										<div class="bulk-actions align-left">
											<select name="dropdown">
												<option value="option1">Choose an action...</option>
												<option value="option2">Edit</option>
												<option value="option3">Delete</option>
											</select>
											<a class="button" href="#">Apply to selected</a>
										</div>
										
										<div class="pagination">
											<a href="#" title="First Page">&laquo; First</a><a href="#" title="Previous Page">&laquo; Previous</a>
											<a href="#" class="number" title="1">1</a>
											<a href="#" class="number" title="2">2</a>
											<a href="#" class="number current" title="3">3</a>
											<a href="#" class="number" title="4">4</a>
											<a href="#" title="Next Page">Next &raquo;</a><a href="#" title="Last Page">Last &raquo;</a>
										</div> <!-- End .pagination -->
										<div class="clear"></div>
									</td>
								</tr>
							</tfoot>
						 
							<tbody>
                                                            <?php
                                                                for($i=0;$i<20;$i++)
                                                                {
                                                                    ?>
                                                                    <tr>
									<td><input type="checkbox" /></td>
									<td>Lorem ipsum dolor</td>
									<td><a href="#" title="title">Sit amet</a></td>
									<td>Consectetur adipiscing</td>
									<td>Donec tortor diam</td>
									<td>
										<!-- Icons -->
										 <a href="#" title="编辑"><img src="<?php echo base_url("resources/images/icons/pencil.png");?>" alt="编辑" /></a>
										 <a href="#" title="删除"><img src="<?php echo base_url("resources/images/icons/cross.png");?>" alt="删除" /></a> 
									</td>
								</tr>
                                                                    <?php
                                                                }
                                                            ?>	
							</tbody>
							
						</table>
						
					</div> <!-- End #tab1 -->
					
					<div class="tab-content" id="tab2">
                                            <form action="#" method="post">
                                              <fieldset>
                                              <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
                                              <p>
                                                  <label>视频名称</label>
                                                  <input class="text-input small-input" type="text"  name="video_title" />
                                                  <span class="input-notification"><!--添加标题要求--></span>
                                                <!-- Classes for input-notification: success, error, information, attention -->
                                                <br />             
                                                </p>
                                              <p>
                                                  <label>讲解教师</label>
                                                  <input class="text-input small-input" type="text"  name="video_title" />
                                                  <span class="input-notification"><!--添加标题要求--></span>
                                                <!-- Classes for input-notification: success, error, information, attention -->
                                                <br />             
                                                </p>
                                              <p>
                                                  <label>选择视频</label>
                                                  <input type="file" name="video" />
                                              </p>
                                              <p>
                                                <label>分类</label>
                                                <select name="video_type" class="small-input">
                                                    <option>1</option>
                                                    <option>2</option>
                                                    <option>3</option>
                                                    <option>4</option>
                                                </select>
                                              </p>
                                              <p>
                                                <label>专辑</label>
                                                <select name="video_album" class="small-input">
                                                    <option>1</option>
                                                    <option>2</option>
                                                    <option>3</option>
                                                    <option>4</option>
                                                </select>
                                              </p>
                                              <p>
                                                <label>视频简介</label>
                                                <textarea class="text-input textarea wysiwyg" id="textarea" name="video_introduction" cols="79" rows="15"></textarea>
                                              </p>
                                              <p>
                                                <input class="button" type="submit" value="Submit" />
                                              </p>
                                              </fieldset>
                                              <div class="clear"></div>
                                              <!-- End .clear -->
                                            </form>
                                          </div>
                                          <!-- End #tab2 -->       
					
				</div> <!-- End .content-box-content -->
				
			</div> <!-- End .content-box -->
			
			<div class="content-box column-left">
				
				<div class="content-box-header">
					
					<h3>Content box left</h3>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
					
					<div class="tab-content default-tab">
					
						<h4>Maecenas dignissim</h4>
						<p>
						Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in porta lectus. Maecenas dignissim enim quis ipsum mattis aliquet. Maecenas id velit et elit gravida bibendum. Duis nec rutrum lorem. Donec egestas metus a risus euismod ultricies. Maecenas lacinia orci at neque commodo commodo.
						</p>
						
					</div> <!-- End #tab3 -->        
					
				</div> <!-- End .content-box-content -->
				
			</div> <!-- End .content-box -->
			
			<div class="content-box column-right">
				
				<div class="content-box-header"> <!-- Add the class "closed" to the Content box header to have it closed by default -->
					
					<h3>Content box right</h3>
					
				</div> <!-- End .content-box-header -->
				
				<div class="content-box-content">
					
					<div class="tab-content default-tab">
					
						<h4>This box is closed by default</h4>
						<p>
						Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed in porta lectus. Maecenas dignissim enim quis ipsum mattis aliquet. Maecenas id velit et elit gravida bibendum. Duis nec rutrum lorem. Donec egestas metus a risus euismod ultricies. Maecenas lacinia orci at neque commodo commodo.
						</p>
						
					</div> <!-- End #tab3 -->        
					
				</div> <!-- End .content-box-content -->
				
			</div> <!-- End .content-box -->
			<div class="clear"></div>
			
			
			<div id="footer">
				<small> <!-- Remove this notice or replace it with whatever you want -->
						&#169; Copyright 2014 IT微视 | Powered by <a href="#">IT微视</a> | <a href="#">Top</a>
				</small>
			</div><!-- End #footer -->
			
		</div> <!-- End #main-content -->
	</div></body>
</html>
