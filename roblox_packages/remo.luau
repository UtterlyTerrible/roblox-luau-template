local module = require(script.Parent[".pesde"]["littensy_remo@1.5.2"]["remo"])
export type Promise<T> = module.Promise<T>
export type PromiseConstructor  = module.PromiseConstructor 
export type Middleware  = module.Middleware 
export type RemoteBuilder  = module.RemoteBuilder 
export type RemoteBuilderMetadata  = module.RemoteBuilderMetadata 
export type RemoteBuilders  = module.RemoteBuilders 
export type Remotes<Map> = module.Remotes<Map>
export type RemoteMap  = module.RemoteMap 
export type RemoteType  = module.RemoteType 
export type Remote<Args... = ...any> = module.Remote<Args... >
export type ClientToServer<Args... = ...any> = module.ClientToServer<Args... >
export type ServerToClient<Args... = ...any> = module.ServerToClient<Args... >
export type AsyncRemote<Args... = ...any, Returns... = ...any> = module.AsyncRemote<Args... , Returns... >
export type ServerAsync<Args... = ...any, Returns... = ...any> = module.ServerAsync<Args... , Returns... >
export type ClientAsync<Args... = ...any, Returns... = ...any> = module.ClientAsync<Args... , Returns... >
export type ClientToServerAsync<Returns = any, Args... = ...any> = module.ClientToServerAsync<Returns , Args... >
export type ServerToClientAsync<Returns = any, Args... = ...any> = module.ServerToClientAsync<Returns , Args... >
return module