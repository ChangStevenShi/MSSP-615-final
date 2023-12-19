library(shiny)
library(ggplot2)
library(dplyr)
library(magrittr)
library(ggmap)
library(transformr)
library(shinydashboard)
library(plotly)
library(tidyverse)
library(dplyr)
library(rnaturalearth)
library(sf)
library(leaflet)
library(DT)



##############################################################################

ui <- dashboardPage(
 
   #######################SideBar##################
  skin = "blue",
  dashboardHeader(title = "Comoros Analysis Report"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home Page", tabName = "Home", icon = icon("dashboard")),
      menuItem("The Pacific", tabName = "Pacific", icon = icon("map")),
      menuItem("General Description", tabName = "PO", icon = icon("info-circle"),
               menuSubItem("Map of Comoros", tabName = "AP",icon = icon("map")),
               menuSubItem("World Map", tabName = "BP",icon = icon("map")),
               menuSubItem("Key Facts", tabName = "CP",icon = icon("key")),
               menuSubItem("Brief Narrative Description", tabName = "DP",icon = icon("book"))),
      menuItem("Key Demographics", tabName = "Demographics", icon = icon("users")), 
      menuItem("Comparison", tabName = "Comparison", icon = icon("balance-scale")),
      menuItem("SWOT", tabName = "P1", icon = icon("project-diagram"),
               menuSubItem("Strength", tabName = "EP",icon = icon("thumbs-up")),
               menuSubItem("Weakness", tabName = "FP",icon = icon("thumbs-down")),
               menuSubItem("Opportunities", tabName = "IP",icon = icon("lightbulb")),
               menuSubItem("Threats", tabName = "JP",icon = icon("exclamation-triangle"))),
      menuItem("Help", tabName = "Help", icon = icon("clipboard-list"))
    )#sidebarMenu_end
  ),
  #dashboardSidebar_end
  
  ### BoarBody ###
  dashboardBody(
    
    
    tabItems(
      ################Home Page#############
      tabItem(tabName = "Home", 
              #Greetings
              h2("Comoros Analysis Report"),
              
              #Heading image
              fluidRow(h3(""),h3(""),h3(""),column(12,mainPanel(imageOutput("home")))),
 
              h4("This Application is developed by Chang Shi. 
                 The purpose of this application is to analyze the population of Comoros Island, 
                 and the location of the island, compared with other islands and Comoros SWTO.")
      )#hometabitem_end
      ,
      
      ###### The Pacific #####
      tabItem(tabName = "Pacific",
              fluidPage(
                titlePanel("Presentation of samples"),
                mainPanel(
                  img(src="sample.svg",
                      height="600",
                      width="800")
                )
              )
      ),
      
      ###### General Description #####
      
      tabItem(tabName = "AP",
              fluidPage(
                titlePanel("Map of the Comoros"),

                  mainPanel(
                    leafletOutput("comorosMap", width = "100%", height = "650px") #map output
                  )
              )
      ),# Map Island item end
      
      tabItem(tabName = "BP",
              fluidPage(
                titlePanel("Map showing the location of the Comoros in the world"),
                  mainPanel(
                    leafletOutput("worldMap", width = "100%", height = "650px") #map output
                  )
              )
      ),# Showing Map Island item end
      
      tabItem(tabName = "CP",
              fluidPage(
                titlePanel("Key facts about the Comoros"),
                mainPanel(
                  HTML('<img src="flag.jpg" style="width:100%;">'),
                  HTML('<p style="font-size:18px;">Capital: Moroni</p>'),
                  HTML('<p style="font-size:18px;">Area: 1,861 sq km</p>'),
                  HTML('<p style="font-size:18px;">Population: 850,800.</p>'),
                  HTML('<p style="font-size:18px;">Languages: Comorian, French, Arabic</p>'),
                  HTML('<p style="font-size:18px;">Life expectancy: 62 years (men) 67 years (women)</p>')
                )
              )
      ),# key facts item end
      
      tabItem(tabName = "DP",
              h2("A brief narrative description of the Comoros"),
              
              fluidRow(h3(""),h3(""),h3(""),column(12,mainPanel(imageOutput("brief")))),
              
              h4("The Cormoros, enchantingly known as the Perfumed Islands, are a mesmerizing 
                 blend of aromatic flora, rich cultural diversity, and breathtaking natural beauty.   
                 Nestled in the Indian Ocean, these islands are a tapestry of African, Arab, and 
                 French influences, reflected in their languages, music, and cuisine.   Despite 
                 facing environmental and socio-economic challenges, the Cormoros captivate with 
                 their volcanic landscapes, lush rainforests, and pristine beaches, all under the 
                 warm, resilient spirit of its people.")
      )
      ,# Brief item end
      ##### General Description Ending ######

      ##### Key Demographics ######
      
      tabItem(tabName = "Demographics",
              fluidPage(
                titlePanel("Key demographics"),
                  mainPanel(
                    HTML('<img src="j2.jpeg" style="width:100%;">'),
                    HTML('<p style="font-size:18px;">Population data from UNdata</p>'),
                    plotOutput("populationPlot"),
                    DTOutput("popTable")
                  )
              )
      ),# Demographics item end
      
      
      ##### Comparison ######
      
      tabItem(tabName = "Comparison",
              fluidPage(
                titlePanel("Comparison of the Comoros relative to other island states in the same region"),
                  mainPanel(
                    HTML('<img src="j3.jpeg" style="width:100%;">'),
                    HTML('<p style="font-size:18px;">This app chooses Comoros to make a comprehensive comparison with Mauritius,
                         and analyzes the situation of Comoros through population, economy, food, religion and education to 
                         better understand the situation of Comoros from the side.</p>'),
                    DTOutput("comparisonTable")
                  )
              )
      ),# Comparison item end
      
      
      ###### SWOT #####
      
      tabItem(tabName = "EP",
              fluidPage(
                titlePanel("Strength analysis of the Comoros"),
                  mainPanel(
                    HTML('<img src="j4.jpg" style="width:30%;">'),
                    HTML('<p style="font-size:18px;">the Comoros SWTO of this app is analyzed according to the article Coastal 
                         Livelihoods in the Union of Comoros, so the main direction is focused on the Marine part.</p>'),
                    HTML('<p style="font-size:18px;">Potential increase in high seas fishing production: The Comoros has the 
                         potential to significantly increase its fishing production, especially in the high seas.</p>'),
                    HTML('<p style="font-size:18px;">Good investment climate: The Comoros Government has created a positive 
                         investment climate conducive to economic development and growth.</p>'),
                    HTML('<p style="font-size:18px;">Presence of artisanal fisheries sector: The country has a mature 
                         artisanal fisheries sector with sufficient scale and expertise to provide a solid foundation for 
                         the proper development of the sector.</p>'),
                    plotOutput("swotPlot")
                  )
              )
      ),# strength item end
      
      tabItem(tabName = "FP",
              fluidPage(
                titlePanel("Weakness analysis of the Comoros"),
                  mainPanel(
                    HTML('<img src="j4.jpg" style="width:30%;">'),
                    HTML('<p style="font-size:18px;">Geographic isolation: The isolation of the three islands of the 
                         Comoros poses logistical and economic challenges.</p>'),
                    HTML('<p style="font-size:18px;">Lack of data and information: Lack of data and information 
                         about resource availability and management.</p>'),
                    HTML('<p style="font-size:18px;">Limited participation of civil society and the private sector: 
                         In the fisheries sector, participation of civil society and the private sector is low.</p>'),
                    HTML('<p style="font-size:18px;">Underdeveloped industry planning and legislation: Development 
                         planning and legislation for the industry have not yet been implemented, indicating the 
                         lack of a strong regulatory framework.</p>'),
                    HTML('<p style="font-size:18px;">Lack of training and research tools: Lack of resources for 
                         sectoral assessment and training facilities.</p>')
                  )
              )
      ),# Weakness item end
      
      tabItem(tabName = "IP",
              fluidPage(
                titlePanel("Opportunities analysis of the Comoros"),
                  mainPanel(
                    HTML('<img src="j4.jpg" style="width:30%;">'),
                    HTML('<p style="font-size:18px;">Untapped high-value niches: There are untapped 
                         markets in areas such as cephalopods and rock lobsters that offer potential 
                         for economic growth.</p>'),
                    HTML('<p style="font-size:18px;">Market demand for fishery products: 
                         There is strong national, regional and international demand for fishery 
                         products, which the Comoros can take advantage of.</p>'),
                    HTML('<p style="font-size:18px;">Development of the fisheries sector: 
                    The Governments commitment to the development of small-scale fisheries 
                    provides opportunities for growth in the sector.</p>')
                  )
              )
      ),# opportunities item end
      
      tabItem(tabName = "JP",
              fluidPage(
                titlePanel("Threats analysis of the Comoros"),
                  mainPanel(
                    HTML('<img src="j4.jpg" style="width:30%;">'),
                    HTML('<p style="font-size:18px;">Multiple operations in coastal areas: Population pressure in coastal 
                         areas and activities such as material mining can further exacerbate environmental problems.</p>'),
                    HTML('<p style="font-size:18px;">Overexploited coastal areas: Years of heavy development without 
                         effective resource monitoring pose a major threat to the sustainability of coastal ecosystems.</p>'),
                    HTML('<p style="font-size:18px;">Reference: Ali Youssouf,"Coastal Livelihoods in the Union of Comoros",2010,https://www.nairobiconvention.org/clearinghouse/node/479 </p>')
                  )
              )
      ),# threats item end
      ##### SWOT Ending ######
      
      ###### Help #####
      tabItem(tabName = "Help",  
              fluidPage(
                titlePanel("Help and Support"),
                  mainPanel(
                    h3("Contact Chang Shi"),
                    p("If you need help or support, please email me at:"),
                    a("Email Support Team", href = "mailto:shichang@bu.edu")  # email here
                  )
              )
      )#help item end
    
    
    ) # item end
  ) #dashboardBody_end
  
)#dashboardPage_end



#################server#################
server <- function(input,output, session){
  ##########home page###########
  output$home<- renderImage({Leg<-"www/home.jpg"
  list(src=Leg,height=380,wide=600)
  },deleteFile = FALSE)
  
 ###### map #######
  # Get geographic data for Comoros
  countries <- ne_countries(scale = "medium", returnclass = "sf")
  comoros <- subset(countries, admin == "Comoros")
  
  # Detailed map of Comoros related cities
  output$comorosMap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addPolygons(data = comoros, fillColor = "purple", weight = 1, smoothFactor = 0.5) %>%
      setView(lng = mean(st_coordinates(st_centroid(comoros))[,1]), 
              lat = mean(st_coordinates(st_centroid(comoros))[,2]), zoom = 7)
  })
  
  # World map showing the location of Comoros
  output$worldMap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Esri.WorldStreetMap) %>%
      setView(lng = mean(st_coordinates(st_centroid(comoros))[,1]), 
              lat = mean(st_coordinates(st_centroid(comoros))[,2]), zoom = 2) %>%
      addMarkers(lng = mean(st_coordinates(st_centroid(comoros))[,1]), 
                 lat = mean(st_coordinates(st_centroid(comoros))[,2]), popup = "Comoros")
  })
  ###### map end#######  
  
  ###### brief#######
  output$brief<- renderImage({Leg<-"www/j0.jpg"
  list(src=Leg,height=380,wide=600)
  },deleteFile = FALSE)
  
  
  ###### Demographics #######
  output$populationPlot <- renderPlot({
    # Data has been cleared
    population_data <- read.csv("population.csv")
    
    # Create a bar chart
    ggplot(population_data, aes(x = Year, y = Population)) +
      geom_bar(stat = "identity", fill = "yellow") +
      theme_minimal() +
      labs(title = "Population of the Comoros (2013-2023)",
           x = "Year",
           y = "Population")
  })
  
  populationData <- read.csv("population.csv")
  output$popTable <- renderDT({
    datatable(populationData)
  })
    
    
  ###### comparison #######
  comparisonData <- read.csv("compare.csv")

  output$comparisonTable <- renderDT({
    datatable(comparisonData)
  })
  
  
  ###### SWTO #######
  
  output$swotPlot <- renderPlot({
    swot_data <- data.frame(
      category = c(rep("Strengths", 3), rep("Weaknesses", 5), rep("Opportunities", 3), rep("Threats", 2)),
      details = c(
        "Potential increase in open sea fishing", "Favorable investment climate", "Established artisanal fishery sector",
        "Geographical isolation", "Lack of data and information", "Limited civil society participation", "Underdeveloped sector planning", "Absence of training and research tools", 
        "Development of fishing sector", "Market demand for fishery products", "Untapped high-value niche markets",
        "Overexploited coastal areas", "Multiple operations in coastal areas"
      )
    )
    

    ggplot(swot_data, aes(x = category, y = details)) +
      geom_tile() +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "SWOT Analysis of Comoros", x = "", y = "")
  })
  
  
  ###### SWTO end #######
  
}#server_end




###########Run#############
shinyApp(ui = ui, server = server)