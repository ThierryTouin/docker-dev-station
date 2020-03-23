<?php
/*-----------------------------------------------------------------------*
   Copyleft (c) 2020 by Dominique Laporte(dominique.laporte@ac-aix-marseille.fr)

   This file is part of QDRep.

   QDRep is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   QDRep is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with QDRep.  If not, see <http://www.gnu.org/licenses/>.
*-----------------------------------------------------------------------*/

//error_reporting(E_ALL);

class Template
{
	private $tpl = "";
	// constructeur -------------------------------------------------	
	public function Template($file)
	{
		if ( file_exists($file) )
			$this->tpl = file_get_contents($file);
	}
	// remplace les variables du gabarit ----------------------------		
	public function setVar($var, $data, $array = array())
	{
		if ( !is_array($array) )
			$array = array($array);
		for ($i = 0; $i < count($array); $i++)
			$data = str_replace("{".$i."}", $array[$i], $data);

		$this->tpl = str_replace("{\$".$var."}", $data, $this->tpl);
	}
	// renvoie le gabarit complété ----------------------------------	
	public function render()
	{
		return $this->tpl;
	}
}
//---------------------------------------------------------------------------
function get_IP()
{
	// Gestion des proxys
	if ( isset($_SERVER['HTTP_X_FORWARDED_FOR']) ) 
		$IP = $_SERVER['HTTP_X_FORWARDED_FOR'];  
	else
		$IP = isset($_SERVER['HTTP_CLIENT_IP'])
			? $_SERVER['HTTP_CLIENT_IP']
			: $_SERVER['REMOTE_ADDR'];

	return $IP;
}

function delTree($dir)
{
	if ( in_array($dir, array('.', '..')) )
		return False;
		
	$files = array_diff(scandir($dir), array('.', '..'));
	foreach ($files as $file)
		is_dir("$dir/$file") ? delTree("$dir/$file") : unlink("$dir/$file");
	
	return rmdir($dir);
}

function get_path()
{
	$uri  = substr_count($_SERVER['REQUEST_URI'], '/');

	$path = ".";
	for ($i = 2; $i < $uri; $i++)
		$path = $path . "/..";

	return $path;
}

function read_content(&$files, &$mydir)
{
	// lecture des fichiers et des dossiers
	$dir   = ".";
	$myDir = @opendir($dir);

	while ( $entry = readdir($myDir) ) {
		// les fichiers
		if ( is_file("$dir/$entry") )
			switch ( $entry ) {
				case "." :
				case ".." :
				case "index.php" :
					break;

				default :
					// les fichiers cachés commencent par le caractère .
					if ( $entry[0] != '.' )
						$files[] = $entry;
					break;
				}

		// les dossiers
		if ( is_dir("$dir/$entry") )
			switch ( $entry ) {
				case "." :
					break;

				case ".." :
					// on ne remonte pas au delà de la racine
					if ( substr_count($_SERVER['REQUEST_URI'], '/') > 2 )
						$mydir[] = $entry;
					break;

				default :
					// les dossiers cachés commencent par le caractère .				
					if ( $entry[0] != '.' )				
						$mydir[] = $entry;
					break;
				}
			}

	// Tri des fichiers et des dossiers
	@sort($files);
	@sort($mydir);

	closedir($myDir);
}

function select_folders($path, $mydir)
{
	require "$path/.data/config.php";

	// lecture des dossiers
	$dirlist = "";

	if ( $CREATFILE )
		for ($i = 0; $i < count($mydir); $i++ )
			if ( !file_exists("$path/$mydir[$i]/.lck") )
				$dirlist .= "<option value=\"$mydir[$i]\">$mydir[$i]</option>";
		
	return $dirlist;
}

function get_dir($path, $mydir)
{
	require "$path/.data/config.php";

	// lecture des dossiers
	$dirlist = "";
	for ($i = 0; $i < count($mydir); $i++ ) {
		$date = $mydir[$i] == ".."
			? "&nbsp;"
			: date ("d/M/Y H:i", filemtime($mydir[$i]));

		$option = in_array(get_IP(), $PASSWD) && !in_array($mydir[$i], array('.', '..'))
			?	"<button class=\"noborder\" type=\"submit\" name=\"rm\" value=\"$mydir[$i]\">
					<img src=\"$path/.data/img/trash.png\" alt=\"\" />
				</button>"
			:	"&nbsp;" ;

		$dir = $mydir[$i] == ".." ? "parent" : "dir";
		$dirlist .=
			"<tr>
				<td><img src=\"$path/.data/img/$dir.png\" alt=\"\" /></td>
				<td><a href=\"./$mydir[$i]\">$mydir[$i]</a></td>
				<td>&nbsp;</td>
				<td class=\"hide_row\" style=\"text-align:right;\">$date</td>
				<td>&nbsp;</td>
				<td style=\"text-align:right;\">$option</td>
			</tr>";
		}
		
	return $dirlist;
}

function get_files($path, $files, &$total)
{
	require "$path/.data/config.php";

	// lecture des fichiers
	$filelist = "";
	for ($i = 0; $i < count($files); $i++ ) {
		$ext    = pathinfo($files[$i], PATHINFO_EXTENSION);
		$size   = (int) (filesize("./$files[$i]") / 1000);
		$total += $size ? $size : 1;

		if ( !file_exists("$path/.data/img/mime/$ext.png") )
			$ext = "default";

		// indicateur pour fichiers récents
		$delay  = (time()- filemtime($files[$i])) / (24 * 3600);
		$update = $delay < $TIMEOUT
			? "<img src=\"$path/.data/img/updated.png\" alt=\"[updated]\" />"
			: "&nbsp;" ;

		$option = $CREATFILE
			?	"<img src=\"$path/.data/img/config.png\" alt=\"\" onclick=\"modal_file('$files[$i]');\" />"
			:	"&nbsp;" ;

		$option .= in_array(get_IP(), $PASSWD)
			?	"<button class=\"noborder\" type=\"submit\" name=\"rm\" value=\"$files[$i]\">
					<img src=\"$path/.data/img/trash.png\" alt=\"\" />
				</button>"
			:	"&nbsp;" ;

		$filesize  = $size ? $size : "<1";
		$filelist .=
			"<tr>
				<td><img src=\"$path/.data/img/mime/$ext.png\" alt=\"[$ext]\" /></td>
				<td><a href=\"./$files[$i]?time=".time()."\" ".target($ext).">$files[$i]</a></td>
				<td style=\"text-align:right; white-space:nowrap;\">$filesize ko</td>
				<td class=\"hide_row\" style=\"text-align:right;\">".date ("d/M/Y H:i", filemtime($files[$i]))."</td>
				<td>$update</td>
				<td style=\"white-space:nowrap;\">$option</td>
			</tr>";			
		}
		
	return $filelist;
}

function readonly($path)
{
	require "$path/.data/config.php";

	$lock = file_exists(".lck")
		? "locked"
		: "unlocked" ;

	$readonly = in_array(get_IP(), $PASSWD)
		?	"<button class=\"noborder\" type=\"submit\" name=\"lock\" value=\"$lock\">
				<img src=\"$path/.data/img/$lock.png\" alt=\"\" />
			</button>"
		:	"" ;

	return $readonly;
}

function current_URL()
{
	$referer  = explode("/", $_SERVER['SERVER_NAME']);
	$keywords = explode("/", $_SERVER['REQUEST_URI']);

	$url = "http://$referer[0]/";
	for ($i = 1; $i < count($keywords); $i++)
		if ( $keywords[$i] != "" )
			$url   .= "$keywords[$i]/";

	return $url;
}

function Ariane_Thread()
{
	$referer  = explode("/", $_SERVER['SERVER_NAME']);
	$keywords = explode("/", $_SERVER['REQUEST_URI']);

	$href   = "http://$referer[0]/";
	$thread = "<a href=\"$href\">$referer[0]</a> / ";
	for ($i = 1; $i < count($keywords); $i++)
		if ( $keywords[$i] != "" ) {
			$href   .= "$keywords[$i]/";
			$thread .= "<a href=\"$href\">$keywords[$i]</a> / ";
			}

	return $thread;
}


function get_referer($home)
{
	$referer  = explode("/", $_SERVER['SERVER_NAME']);
	$keywords = explode("/", $_SERVER['REQUEST_URI']);

	return $referer[0]."/".$keywords[1]."/".$home;
}

function stripaccent($string)
{
	$encoding = iconv_get_encoding();

	return str_replace(
		Array(' ', 'à','ä','â','é','è','ë','ê','ï','î','ö','ô','ù','ü','û','ç'),
		Array('_', 'a','a','a','e','e','e','e','i','i','o','o','u','u','u','c'),
		iconv($encoding['input_encoding'], "UTF-8", trim($string))
		);
}

function clean($string)
{
	$string = stripaccent(strtolower($string));

	$newtring = "";
	for ($i = 0; $i < strlen($string); $i++)
		if ( ctype_alnum($string[$i]) ||  $string[$i] == '_' )
			$newtring .= $string[$i];

	return $newtring;
}

function target($ext)
{
	return in_array($ext, array('htm', 'html', 'php', 'js'))
		? "download"
		: "target=\"_blank\"";
}

function modal(&$tpl, $title, $message, $data = array())
{
	$tpl->setVar("modal", "block");
	$tpl->setVar("modal_title", $title);
	$tpl->setVar("modal_text", $message, $data);
}

function is_scriptable($file)
{
	$contents = file_get_contents($file);

	if ( strlen(stristr($contents, '<?php')) )
		return file_put_contents($file, str_replace('<?php', '<?', $contents));
	
	return false;
}
//---------------------------------------------------------------------------
$path = get_path();
$tpl  = new Template("$path/.data/index.tpl");

require "$path/.data/config.php";
require "$path/.data/msg/$LANG.php";

//-- création répertoire
if ( @$_POST["newdir"] && $CREATDIR ) {
	$newdir = in_array(get_IP(), $PASSWD)
		? stripaccent($_POST["newdir"])
		: clean($_POST["newdir"]);

	if ( strlen($newdir) && !file_exists($newdir) )
		if ( mkdir($newdir, 0777, true) ) {
			$up = "";
			for ($i = 0; $i < count(explode('/', $path)); $i++)
				$up .= "../";
				
			$fp = fopen("$newdir/index.php", "w");
			fwrite($fp, "<?php require '".$up."index.php'; ?>");
			fclose($fp);

			if ( $AUTOLOCK )
				fclose(fopen("$newdir/.lck", 'w'));
		}
	}

//-- suppression répertoire / fichier
if ( @$_POST["rm"] && in_array(get_IP(), $PASSWD) ) {
	if ( is_dir($_POST["rm"]) )
		$retcode = delTree($_POST["rm"]);
	else
		$retcode = unlink($_POST["rm"]);

	if ( !$retcode )
		modal($tpl, $MSG_ERROR, $MSG_ERRDELETE, $_POST["rm"]);
	}

//-- verrouillage répertoire
if ( @$_POST["lock"] && in_array(get_IP(), $PASSWD) )
	if ( @$_POST["lock"] == "locked" )
		unlink(".lck");
	else
		fclose(fopen(".lck", 'w'));

//-- téléversement fichier
if ( @$_FILES['UploadedFile'] )
	if ( $_FILES['UploadedFile']['size'] ) {
		if ( $_FILES['UploadedFile']['size'] > $MAXFILE )
			modal($tpl, $MSG_ERROR, $MSG_ERRSIZE);
		else
			if ( substr($_FILES['UploadedFile']['name'], 0, strlen("index.")) != "index." ) {
				$UploadedFile = stripaccent($_FILES['UploadedFile']['name']);
				if ( !copy($_FILES['UploadedFile']['tmp_name'], $UploadedFile) )
					modal($tpl, $MSG_ERROR, $MSG_ERRCOPY, $UploadedFile);
				else {
					//$ext = pathinfo($UploadedFile, PATHINFO_EXTENSION);
					// html_entity_decode(htmlentities($orig));
					is_scriptable($UploadedFile);
					}
				}
		}

//-- renommage fichier
if ( @$_POST["dst_file"] && $CREATFILE ) {
	$src_file = @$_POST["src_file"];
	$dst_file = stripaccent($_POST["dst_file"]);

	if ( $CREATFILE )
		if ( !rename($src_file, $dst_file) )
			modal($tpl, $MSG_ERROR, $MSG_ERRRENAME, array($src_file, $dst_file));
		else
			$_POST["src_file"] = $dst_file;	// si déplacement dans la foulée...
	}

//-- déplacement fichier
if ( @$_POST["moveto"] && $CREATFILE ) {
	$src_file = @$_POST["src_file"];
	$folder   = @$_POST["moveto"];

	if ( $CREATFILE && !file_exists("./$folder/.lck") )
		if ( !rename($src_file, $folder."/".$src_file) )
			modal($tpl, $MSG_ERROR, $MSG_ERRMOVE, array($src_file, $folder));
	}
//---------------------------------------------------------------------------
$tpl->setVar("path", $path);
$tpl->setVar("lang", $LANG);
$tpl->setVar("charset", $CHARSET);
$tpl->setVar("title", $MSG_TITLE);
$tpl->setVar("subtitle", $MSG_SUBTITLE);
$tpl->setVar("href", Ariane_Thread());
$tpl->setVar("lock", readonly($path));
$tpl->setVar("ip", "@IP -> ".get_IP());
$tpl->setVar("name", $MSG_NAME);
$tpl->setVar("size", $MSG_SIZE);
$tpl->setVar("update", $MSG_UPDATE);

$option = $CREATDIR && !file_exists(".lck")
	? "<input name=\"newdir\" type=\"text\" placeholder=\"$MSG_NEWDIR\" /><input type=\"submit\" />"
	: "" ;
	
$tpl->setVar("newdir", $option);

//---- liste des fichiers et des dossiers présents
$files = array();
$mydir = array();
	
read_content($files, $mydir);
//$files = @array_values($files);	// Réindexation du tableau selon le nouvel ordre

$total = 0;
$tpl->setVar("filelist", get_files($path, $files, $total));
$tpl->setVar("dirlist", get_dir($path, $mydir));

if ( $CREATFILE && !file_exists(".lck") )
	$tpl->setVar("newfile", 
			"<tr>
				<td><img src=\"$path/.data/img/file.png\" alt=\"\" /></td>
				<td><input name=\"UploadedFile\" type=\"file\" /><input type=\"submit\" /></td>
				<td>&nbsp;</td>
				<td class=\"hide_row\">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>");			
else
	$tpl->setVar("newfile", "");

$tpl->setVar("files", $MSG_TOTAL, array(count($mydir), count($files), $total));
$tpl->setVar("referer", get_referer("index.php"));
$tpl->setVar("about_text", $MSG_QDREP);
$tpl->setVar("version", $VERSION);
$tpl->setVar("action", current_URL());
$tpl->setVar("rename", $MSG_RENAME);
$tpl->setVar("move", $MSG_MOVE);
$tpl->setVar("currdir", $MSG_CURRDIR);
$tpl->setVar("select_options", select_folders($path, $mydir));

echo $tpl->render();
?>