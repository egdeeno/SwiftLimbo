import Foundation
import PackagePlugin

@main
struct SwiftGenPlugin: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        
        //let inputJSON = target.directory.appending("Source.json")
        //let output = target.directory.appending("GeneratedEnum.swift")//context.pluginWorkDirectory.appending("GeneratedEnum.swift")
        var utsnameInstance = utsname()
        uname(&utsnameInstance)
        var cpuArch: String = withUnsafePointer(to: &utsnameInstance.machine) {
             $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingCString: ptr)
             }
        } ?? ""
        if cpuArch == "arm64" {
          cpuArch = "aarch64"
        }
        var os = "apple-darwin"
        #if os(iOS)
           os = "apple-ios"
        #elseif os(Linux)
           os = "unknown-linux-gnu"
        #elseif os(Windows)
           os = "pc-windows-msvc"
        #endif
        
        let executableScript = target.directory.appending("build.sh")
        //Path("/usr/bin/make"),//.init("/usr/bin/make"), //try context.tool(named: "/usr/bin/make").path,
        
        let outputFilesDir = context.pluginWorkDirectory //target.directory
        
        return [
            .prebuildCommand(displayName: "Generate static Lib",
                          executable: executableScript,
                          arguments: [target.directory, cpuArch, os],
                          environment: [:],
                          outputFilesDirectory: outputFilesDir)
        ]
    }
}
