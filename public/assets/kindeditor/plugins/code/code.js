/*******************************************************************************
* KindEditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 kindsoft.net
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence http://www.kindsoft.net/license.php
*******************************************************************************/
KindEditor.plugin("code",function(o){var t=this,e="code";t.clickToolbar(e,function(){var i=t.lang(e+"."),a=['<div style="padding:10px 20px;">','<div class="ke-dialog-row">','<select class="ke-code-type">','<option value="js">JavaScript</option>','<option value="html">HTML</option>','<option value="css">CSS</option>','<option value="php">PHP</option>','<option value="pl">Perl</option>','<option value="py">Python</option>','<option value="rb">Ruby</option>','<option value="java">Java</option>','<option value="vb">ASP/VB</option>','<option value="cpp">C/C++</option>','<option value="cs">C#</option>','<option value="xml">XML</option>','<option value="bsh">Shell</option>','<option value="">Other</option>',"</select>","</div>",'<textarea class="ke-textarea" style="width:408px;height:260px;"></textarea>',"</div>"].join(""),n=t.createDialog({name:e,width:450,title:t.lang(e),body:a,yesBtn:{name:t.lang("yes"),click:function(){var e=o(".ke-code-type",n.div).val(),a=p.val(),l=""===e?"":" lang-"+e,v='<pre class="prettyprint'+l+'">\n'+o.escape(a)+"</pre> ";return""===o.trim(a)?(alert(i.pleaseInput),void p[0].focus()):void t.insertHtml(v).hideDialog().focus()}}}),p=o("textarea",n.div);p[0].focus()})});