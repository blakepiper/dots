'use strict';
var order = [], floating = [], busy = false, layouts = {}, ratios = {};
function eligible(w) { return w && w.normalWindow && !w.transient && !w.specialWindow && w.moveable && w.resizeable && floating.indexOf(w)<0 && !w.minimized && !w.fullScreen && !w.onAllDesktops && w.desktops.indexOf(workspace.currentDesktop)>=0; }
function windows() { return order.filter(eligible); }
function place(w,r) { w.setMaximize(false,false); w.noBorder=true; w.frameGeometry={x:r.x,y:r.y,width:r.width,height:r.height}; }
function arrange() {
 if(busy) return; busy=true;
 try {
  var list=windows(), groups=[];
  list.forEach(function(w){ var g=groups.filter(function(g){return g.output===w.output;})[0];if(!g){g={output:w.output,ws:[]};groups.push(g);}g.ws.push(w); });
  groups.forEach(function(g){
   var a=workspace.clientArea(KWin.MaximizeArea,g.output,workspace.currentDesktop), r={x:a.x,y:a.y,width:a.width,height:a.height};
   var id=workspace.currentDesktop.id, mode=layouts[id]||'dwindle', ratio=ratios[id]||0.5;
   if(mode==='master' && g.ws.length>1){var width=Math.round(r.width*ratio);place(g.ws[0],{x:r.x,y:r.y,width:width,height:r.height});var h=Math.floor(r.height/(g.ws.length-1));for(var k=1;k<g.ws.length;k++)place(g.ws[k],{x:r.x+width,y:r.y+(k-1)*h,width:r.width-width,height:k===g.ws.length-1?r.height-(k-1)*h:h});return;}
   for(var i=0;i<g.ws.length;i++) {
    if(i===g.ws.length-1){place(g.ws[i],r);break;}
    var horizontal=i%2===0, size=Math.round((horizontal?r.width:r.height)*(i===0?ratio:0.5));
    var tile={x:r.x,y:r.y,width:horizontal?size:r.width,height:horizontal?r.height:size};place(g.ws[i],tile);
    if(horizontal){r.x+=size;r.width-=size;}else{r.y+=size;r.height-=size;}
   }
  });
 } finally { busy=false; }
}
function watch(w){if(order.indexOf(w)>=0)return;order.push(w);['minimizedChanged','desktopsChanged','outputChanged','fullScreenChanged'].forEach(function(s){if(w[s])w[s].connect(arrange);});arrange();}
function focus(delta){var ws=windows(),i=ws.indexOf(workspace.activeWindow);if(ws.length)workspace.activeWindow=ws[(i+delta+ws.length)%ws.length];}
function swap(delta){var ws=windows(),w=workspace.activeWindow,i=ws.indexOf(w);if(i<0||ws.length<2)return;var other=ws[(i+delta+ws.length)%ws.length],a=order.indexOf(w),b=order.indexOf(other);order[a]=other;order[b]=w;arrange();}
function bind(id,key,fn){registerShortcut('KDE '+id,id,key,fn);}
['Left','Up'].forEach(function(k){bind('Focus '+k,'Meta+'+k,function(){focus(-1);});bind('Swap '+k,'Meta+Shift+'+k,function(){swap(-1);});});
['Right','Down'].forEach(function(k){bind('Focus '+k,'Meta+'+k,function(){focus(1);});bind('Swap '+k,'Meta+Shift+'+k,function(){swap(1);});});
bind('Toggle floating','Meta+P',function(){var w=workspace.activeWindow;if(!w||!w.normalWindow)return;var i=floating.indexOf(w);if(i<0){floating.push(w);w.noBorder=false;var a=workspace.clientArea(KWin.MaximizeArea,w.output,workspace.currentDesktop);w.frameGeometry={x:a.x+a.width*.15,y:a.y+a.height*.15,width:a.width*.7,height:a.height*.7};}else floating.splice(i,1);arrange();});
bind('Recursive splits','Meta+R',function(){layouts[workspace.currentDesktop.id]='dwindle';arrange();});
bind('Master and stack','Meta+C',function(){layouts[workspace.currentDesktop.id]='master';arrange();});
bind('Cycle layout','Meta+N',function(){var id=workspace.currentDesktop.id;layouts[id]=layouts[id]==='master'?'dwindle':'master';arrange();});
bind('Shrink first split','Meta+-',function(){var id=workspace.currentDesktop.id;ratios[id]=Math.max(.2,(ratios[id]||.5)-.05);arrange();});
bind('Grow first split','Meta+=',function(){var id=workspace.currentDesktop.id;ratios[id]=Math.min(.8,(ratios[id]||.5)+.05);arrange();});
workspace.windowAdded.connect(watch);
workspace.windowRemoved.connect(function(w){var i=order.indexOf(w);if(i>=0)order.splice(i,1);i=floating.indexOf(w);if(i>=0)floating.splice(i,1);arrange();});
workspace.currentDesktopChanged.connect(arrange);
workspace.screensChanged.connect(arrange);
if(workspace.virtualScreenGeometryChanged)workspace.virtualScreenGeometryChanged.connect(arrange);
workspace.windowList().forEach(watch);
print('KDE tiling started: '+order.length+' windows');
