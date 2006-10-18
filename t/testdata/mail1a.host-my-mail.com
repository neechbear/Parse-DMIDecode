# dmidecode 2.6
SMBIOS 2.3 present.
49 structures occupying 1415 bytes.
Table at 0x000F0800.
Handle 0x0000
	DMI type 0, 24 bytes.
	BIOS Information
		Vendor: Phoenix Technologies, LTD
		Version: 6.00 PG
		Release Date: 02/27/2006
		Address: 0xE0000
		Runtime Size: 128 kB
		ROM Size: 512 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			BIOS ROM is socketed
			EDD is supported
			5.25"/360 KB floppy services are supported (int 13h)
			5.25"/1.2 MB floppy services are supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 27 bytes.
	System Information
		Manufacturer: Supermicro
		Product Name: P8SCT
		Version: 1234567890
		Serial Number: 1234567890
		UUID: 64837263-8462-7493-1212-003048893452
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Supermicro
		Product Name: P8SCT
		Version: PCB Version
		Serial Number: 1234567890
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: Supermicro
		Type: Desktop
		Lock: Not Present
		Version: 1234567890
		Serial Number:  
		Asset Tag:  
		Boot-up State: Unknown
		Power Supply State: Unknown
		Thermal State: Unknown
		Security Status: Unknown
		OEM Information: 0x00000000
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: Socket 478
		Type: Central Processor
		Family: Pentium 4
		Manufacturer: Intel
		ID: 43 0F 00 00 FF FB EB BF
		Signature: Type 0, Family 15, Model 4, Stepping 3
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			PAE (Physical address extension)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			APIC (On-chip APIC hardware supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			PSE-36 (36-bit page size extension)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			SS (Self-snoop)
			HTT (Hyper-threading technology)
			TM (Thermal monitor supported)
			PBE (Pending break enabled)
		Version: Intel(R) Pentium(R) 4 CPU
		Voltage: 0.0 V
		External Clock: 200 MHz
		Max Speed: 3066 MHz
		Current Speed: 3000 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
		L1 Cache Handle: 0x000A
		L2 Cache Handle: 0x000B
		L3 Cache Handle: Not Provided
		Serial Number:  
		Asset Tag:  
		Part Number:  
Handle 0x0005
	DMI type 5, 24 bytes.
	Memory Controller Information
		Error Detecting Method: 8-bit Parity
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 1024 MB
		Maximum Total Memory Size: 4096 MB
		Supported Speeds:
			Other
		Supported Memory Types:
			Other
		Memory Module Voltage: 5.0 V
		Associated Memory Slots: 4
			0x0006
			0x0007
			0x0008
			0x0009
		Enabled Error Correcting Capabilities:
			None
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM#1
		Bank Connections: 0 1
		Current Speed: Unknown
		Type: Other
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM#2
		Bank Connections: 2 3
		Current Speed: Unknown
		Type: Other
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM#3
		Bank Connections: 4 5
		Current Speed: Unknown
		Type: Other
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM#4
		Bank Connections: 6 7
		Current Speed: Unknown
		Type: Other
		Installed Size: 1024 MB (Double-bank Connection)
		Enabled Size: 1024 MB (Double-bank Connection)
		Error Status: OK
Handle 0x000A
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 32 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000B
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: External Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 2048 KB
		Maximum Size: 2048 KB
		Supported SRAM Types:
			Synchronous
		Installed SRAM Type: Synchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PRIMARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: Other
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SECONDARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: Other
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: FDD
		Internal Connector Type: On Board Floppy
		External Reference Designator: Not Specified
		External Connector Type: None
		Port Type: 8251 FIFO Compatible
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: COM1
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator:  
		External Connector Type: DB-9 male
		Port Type: Serial Port 16450 Compatible
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: COM2
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator:  
		External Connector Type: DB-9 male
		Port Type: Serial Port 16450 Compatible
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: LPT1
		Internal Connector Type: DB-25 female
		External Reference Designator:  
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Keyboard
		Internal Connector Type: PS/2
		External Reference Designator:  
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PS/2 Mouse
		Internal Connector Type: PS/2
		External Reference Designator:  
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB0
		External Connector Type: Other
		Port Type: USB
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB1
		External Connector Type: Other
		Port Type: USB
Handle 0x0016
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB2
		External Connector Type: Other
		Port Type: USB
Handle 0x0017
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB3
		External Connector Type: Other
		Port Type: USB
Handle 0x0018
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB4
		External Connector Type: Other
		Port Type: USB
Handle 0x0019
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB5
		External Connector Type: Other
		Port Type: USB
Handle 0x001A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB6
		External Connector Type: Other
		Port Type: USB
Handle 0x001B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: USB7
		External Connector Type: Other
		Port Type: USB
Handle 0x001C
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI0
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 1
		Characteristics:
			5.0 V is provided
			PME signal is supported
Handle 0x001D
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI-X
		Type: 32-bit PCI-X
		Current Usage: Available
		Length: Long
		ID: 1
		Characteristics:
			5.0 V is provided
Handle 0x001E
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI-X
		Type: 32-bit PCI-X
		Current Usage: Available
		Length: Long
		ID: 69
		Characteristics:
			5.0 V is provided
Handle 0x001F
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI-X
		Type: 32-bit PCI-X
		Current Usage: Available
		Length: Long
		ID: 210
		Characteristics:
			5.0 V is provided
Handle 0x0020
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI-X
		Type: 32-bit PCI-X
		Current Usage: Available
		Length: Long
		ID: 76
		Characteristics:
			5.0 V is provided
Handle 0x0021
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI-X
		Type: 32-bit PCI-X
		Current Usage: Available
		Length: Long
		ID: 210
		Characteristics:
			5.0 V is provided
Handle 0x0022
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 3
			n|US|iso8859-1
			n|US|iso8859-1
			r|CA|iso8859-1
		Currently Installed Language: n|US|iso8859-1
Handle 0x0023
	DMI type 15, 31 bytes.
	System Event Log
		Area Length: 128 bytes
		Header Start Offset: 0x0002
		Header Length: 16 bytes
		Data Start Offset: 0x0012
		Access Method: General-purpose non-volatile data functions
		Access Address: 0x0000
		Status: Valid, Not Full
		Change Token: 0x00000000
		Header Format: Type 1
		Supported Log Type Descriptors: 4
		Descriptor 1: POST error
		Data Format 1: POST results bitmap
		Descriptor 2: Log area reset/cleared
		Data Format 2: None
		Descriptor 3: Multi-bit ECC memory error
		Data Format 3: POST results bitmap
		Descriptor 4: Single-bit ECC memory error
		Data Format 4: POST results bitmap
Handle 0x0024
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 4 GB
		Error Information Handle: Not Provided
		Number Of Devices: 4
Handle 0x0025
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0024
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: DIMM#1
		Bank Locator: Bank0/1
		Type: SDRAM
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x0026
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0024
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: DIMM#2
		Bank Locator: Bank2/3
		Type: SDRAM
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x0027
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0024
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: DIMM#3
		Bank Locator: Bank4/5
		Type: SDRAM
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x0028
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0024
		Error Information Handle: Not Provided
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 1024 MB
		Form Factor: DIMM
		Set: None
		Locator: DIMM#4
		Bank Locator: Bank6/7
		Type: SDRAM
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: None
		Serial Number: None
		Asset Tag: None
		Part Number: None
Handle 0x0029
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x000FFFFFFFF
		Range Size: 4 GB
		Physical Array Handle: 0x0024
		Partition Width: 0
Handle 0x002A
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0003FFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x0025
		Memory Array Mapped Address Handle: 0x0029
		Partition Row Position: 1
Handle 0x002B
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00040000000
		Ending Address: 0x0007FFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x0026
		Memory Array Mapped Address Handle: 0x0029
		Partition Row Position: 1
Handle 0x002C
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00080000000
		Ending Address: 0x000BFFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x0027
		Memory Array Mapped Address Handle: 0x0029
		Partition Row Position: 1
Handle 0x002D
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x000C0000000
		Ending Address: 0x000FFFFFFFF
		Range Size: 1 GB
		Physical Device Handle: 0x0028
		Memory Array Mapped Address Handle: 0x0029
		Partition Row Position: 1
Handle 0x002E
	DMI type 32, 11 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x002F
	DMI type 127, 4 bytes.
	End Of Table
Handle 0x0030
	DMI type 38, 12 bytes.
	IPMI Device Information
Wrong DMI structures length: 1415 bytes announced, structures occupy 1406 bytes.
