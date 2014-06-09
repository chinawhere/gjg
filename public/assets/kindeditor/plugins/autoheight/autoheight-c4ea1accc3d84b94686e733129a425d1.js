/*******************************************************************************
* KindEditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 kindsoft.net
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence http://www.kindsoft.net/license.php
*******************************************************************************/
KindEditor.plugin("autoheight",function(e){function t(){var e=r.edit,t=e.doc.body;e.iframe[0].scroll="no",t.style.overflowY="hidden"}function i(){var t=r.edit,i=t.doc.body;t.iframe.height(a),r.resize(null,Math.max((e.IE?i.scrollHeight:i.offsetHeight)+76,a))}function o(){a=e.removeUnit(r.height),r.edit.afterChange(i),t(),i()}var r=this;if(r.autoHeightMode){var a;r.isCreated?o():r.afterCreate(o)}});