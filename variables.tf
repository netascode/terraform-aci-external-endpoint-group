variable "tenant" {
  description = "Tenant name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.tenant))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "l3out" {
  description = "L3out name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.l3out))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "name" {
  description = "Name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "alias" {
  description = "Alias."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.alias))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "description" {
  description = "Description."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{0,128}$", var.description))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `\\`, `!`, `#`, `$`, `%`, `(`, `)`, `*`, `,`, `-`, `.`, `/`, `:`, `;`, `@`, ` `, `_`, `{`, `|`, }`, `~`, `?`, `&`, `+`. Maximum characters: 128."
  }
}

variable "preferred_group" {
  description = "Preferred group membership."
  type        = bool
  default     = false
}

variable "subnets" {
  description = "List of subnets. Default value `import_route_control`: false. Default value `export_route_control`: false. Default value `shared_route_control`: false. Default value `import_security`: true. Default value `shared_security`: false. Default value `bgp_route_summarization`: false."
  type = list(object({
    name                    = optional(string, "")
    prefix                  = string
    import_route_control    = optional(bool, false)
    export_route_control    = optional(bool, false)
    shared_route_control    = optional(bool, false)
    import_security         = optional(bool, true)
    shared_security         = optional(bool, false)
    bgp_route_summarization = optional(bool, false)
  }))
  default = []

  validation {
    condition = alltrue([
      for s in var.subnets : s.name == null || try(can(regex("^[a-zA-Z0-9_.-]{0,64}$", s.name)), false)
    ])
    error_message = "`name`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "contract_consumers" {
  description = "List of contract consumers."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for c in var.contract_consumers : can(regex("^[a-zA-Z0-9_.-]{0,64}$", c))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "contract_providers" {
  description = "List of contract providers."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for c in var.contract_providers : can(regex("^[a-zA-Z0-9_.-]{0,64}$", c))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "contract_imported_consumers" {
  description = "List of imported contract consumers."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for c in var.contract_imported_consumers : can(regex("^[a-zA-Z0-9_.-]{0,64}$", c))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}
