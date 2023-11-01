
# Document Colours

core<-c("#283d3b",
       "#197278",
       "#83a8a6",
       "#edddd4",
       "#ae9d96",
       "#d99185",
       "#c44536",
       "#772e25")

# Define Theme

graph_theme <-function(){ 
  theme(
    panel.background = element_rect(fill = "white"), 
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(size = 7, color = "black"),
    axis.title = element_blank(),
    axis.ticks = element_blank(), 
    axis.line.x = element_line(colour = "black", size=0.3),
    axis.line.y=element_line(colour="black", size=0.3),
    legend.position="bottom", 
    legend.key = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 8, colour = "black"), 
    legend.box = "horizontal",
    legend.box.just = "center", 
    strip.background = element_rect(fill = "white"),
    strip.text = element_text(colour = "#283d3b", face="bold"),
    plot.title = element_text(size = 14, color = "#283d3b", face = "bold"),
    plot.subtitle = element_text(size = 12, face = "bold", color = "#197278"), 
    plot.caption = element_text(size = 12, color = "#772e25")
  )
}
