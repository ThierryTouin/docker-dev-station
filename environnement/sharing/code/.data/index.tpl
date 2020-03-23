<!DOCTYPE html>
<html dir="ltr" lang="{$lang}">
	<head>
		<title>{$title}</title>

		<meta charset="{$charset}" />
		<meta name="language" content="{$lang}" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="author" content="Dominique Laporte" />
		<meta name="description" content="Ressources pedagogiques Libres et gratuites" />
		<meta name="keywords" content="education,pedagogie,ressource,libre,gratuite,SI,NSI,SIN,informatique,science,numerique" />
		
		<link rel="stylesheet" type="text/css" media="screen" href="{$path}/.data/globals.css" />
		<link rel="icon" type="image/png" href="{$path}/.data/img/favicon.png" />

		<script type="text/javascript" src="{$path}/.data/modal.js"></script>
	</head>

	<body>
		<header id="title">
			<div id="top-menu" >
				<h1>{$title}</h1>
				<h2>{$subtitle}</h2>
			</div>
		</header>

		<form id="myForm" method="post" action="." enctype="multipart/form-data">
			<div class="header">
				<img class="top" src="{$path}/.data/img/url.png" alt="." /> {$href} {$lock} {$ip}
			</div>

			<div class="top">
				<table>
					<tr>
						<th style="width:1%;"><img src="{$path}/.data/img/rsort.png" alt="." /></th>
						<th style="width:50%;">{$name} {$newdir}</th>
						<th style="width:20%; text-align:right;">{$size}</th>
						<th class="hide_row" style="width:20%; text-align:right;">{$update}</th>
						<th style="width:8%;">&nbsp;</th>
						<th style="width:1%;">&nbsp;</th>
					</tr>
					{$dirlist}
					{$filelist}
					{$newfile}
				</table>
			</div>
		</form>

		<footer class="top">
			<a href="#title"><img src="{$path}/.data/img/up.png" alt="^^" /></a> {$files}
			<div class="hide">
				<a href="http://creativecommons.org/licenses/by-nc-sa/2.0/fr/" target="_blank"><img src="{$path}/.data/img/cc-by-nc-sa.png" alt="cc-by-nc-sa" /></a>
				<a href="http://validator.w3.org/check?uri=referer" target="_blank"><img src="{$path}/.data/img/valid_html5.png" alt="valid HTML" /></a>
				<a href="http://jigsaw.w3.org/css-validator/validator?uri=http://{$referer}" target="_blank"><img src="{$path}/.data/img/valid_css.png" alt="valid CSS" /></a>
				<a href="https://www.php.net/" target="_blank"><img src="{$path}/.data/img/valid_php.png" alt="PHP" /></a>
				<a href="https://www.gnu.org/licenses/" target="_blank"><img src="{$path}/.data/img/gnugpl.png" alt="gnu gpl" /></a>
			</div>
			<a href="#about" onclick="document.getElementById('about').style.display='block';" >QDRep</a> {$version}
		</footer>

		<div id="modal">
			<div class="modal_block">
				<img class="modal_close" src="{$path}/.data/img/close.png" alt="X" onclick="document.getElementById('modal').style.display='none';" />
				<h2>{$modal_title}</h2>

				<p>{$modal_text}</p>
			</div>
		</div>

		<script>javascript:document.getElementById('modal').style.display='{$modal}';</script>

		<div id="about">
			<div class="modal_block">
				<img class="modal_close" src="{$path}/.data/img/close.png" alt="X" onclick="document.getElementById('about').style.display='none';" />
				<img style="float:right; margin-left:20px;" src="{$path}/.data/img/kiss.png" alt="" />
				<h2>Quick &amp; Dirty Repository</h2>
				<p style="margin-bottom:30px;">{$about_text}</p>
			</div>
		</div>

		<div id="files">
			<div class="modal_block">
				<img class="modal_close" src="{$path}/.data/img/close.png" alt="X" onclick="document.getElementById('files').style.display='none';" />
				<h2 id="selected_file">_</h2>

				<form id="modalForm" method="post" action="{$action}">
					<input id="src_file" name="src_file" type="hidden" value="_" />

					<div style="padding-bottom:10px;">
						<label>{$rename}</label>
						<input name="dst_file" type="text" />
					</div>
					<div style="padding-bottom:10px;">
						<label>{$move}</label>
						<select name="moveto">
							<option value="" disabled selected>{$currdir}</option>
							{$select_options}
						</select>
					</div>
					<input class="btn" type="submit" />
				</form>
			</div>
		</div>
	</body>
</html>
