env = "dev"

variable "instances" ={
    frontend = {
        app_port = 80
        instance_type = "t3.small"
        }
    cart = {
            app_port = 8080
            instance_type = "t3.small"
            }

    }