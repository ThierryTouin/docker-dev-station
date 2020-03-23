function modal_file(file)
{
	document.getElementById('selected_file').innerHTML = file;
	document.getElementById('src_file').value = file;
	document.getElementById('files').style.display='block';
}