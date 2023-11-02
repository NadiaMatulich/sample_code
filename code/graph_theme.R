
# Document Colours


core <- c("#14213D",    # Dark Blue
          "#FCA311",    # Orange
          "#999999",    # Light Grey
          "#7D3400",    # Darker Orange
          "#000000",    # Black
          "#1B3A5A",    # Lighter Dark Blue
          "#333333",    # Dark Grey
          "#E86900",    # Another Orange
          "#FFFFFF")    # White

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
    strip.text = element_text(colour = "#14213D", face="bold"),
    plot.title = element_text(size = 14, color = "#14213D", face = "bold"),
    plot.subtitle = element_text(size = 12, face = "bold", color = "#1B3A5A"), 
    plot.caption = element_text(size = 12, color = "#E86900")
  )
}
